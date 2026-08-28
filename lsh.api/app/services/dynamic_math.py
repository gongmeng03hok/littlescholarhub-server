import ast
import json
import random
from typing import Any, Dict, List, Optional

from utils.db import qry


class DynamicMathQuestionService:
    """Generate math questions from DB-backed formula templates."""

    FALLBACK_TEMPLATES = [
        {
            "template_id": 1,
            "formula_template": "{a} + {b}",
            "answer_expression": "a + b",
            "description": "Add two numbers",
        },
        {
            "template_id": 2,
            "formula_template": "{a} - {b}",
            "answer_expression": "a - b",
            "description": "Subtract two numbers",
        },
        {
            "template_id": 3,
            "formula_template": "{a} × {b}",
            "answer_expression": "a * b",
            "description": "Multiply two numbers",
        },
    ]

    @classmethod
    def get_db_questions(cls, grade: int, count: int = 5) -> List[Dict[str, Any]]:
        try:
            rows = qry(
                "EXEC dbo.usp_GetDynamicMathQuestions @grade_id = ?, @count = ?",
                (grade, count),
                fetch="all",
            ) or []
            if not rows:
                return []
            out = []
            for row in rows:
                params = row.get("params") or (json.loads(row.get("params_json", "{}")) if row.get("params_json") else {})

                # question text: prefer explicit column, fall back to template/formula
                qtext = row.get("question_text") or row.get("template_text") or row.get("formula_text")
                if not qtext:
                    # try to construct from template + params
                    tpl = row.get("formula_template") or "{a} + {b}"
                    try:
                        qtext = f"What is {tpl.format(**params)}?"
                    except Exception:
                        qtext = tpl

                # correct answer: prefer explicit value, then answer_expression, then try numeric fields
                correct = row.get("correct_answer") or row.get("answer_text") or row.get("answer_expression")
                if correct is None:
                    # if answer_expression present and params available, evaluate it
                    expr = row.get("answer_expression")
                    if expr and params:
                        try:
                            correct = cls._evaluate_expression(expr, params)
                        except Exception:
                            correct = None
                # coerce to string when present
                if correct is not None:
                    correct = str(correct)

                out.append({
                    "question_text": qtext,
                    "correct_answer": correct,
                    "hint": row.get("hint") or row.get("description"),
                    "options": None,
                    "params": params,
                    "template_id": row.get("template_id"),
                })

            return out
        except Exception:
            return []

    @classmethod
    def generate_questions(cls, grade: int, count: int = 5, templates: Optional[List[Dict[str, Any]]] = None, seed: Optional[int] = None) -> List[Dict[str, Any]]:
        db_questions = cls.get_db_questions(grade, count)
        if db_questions:
            return db_questions

        if templates is not None:
            active_templates = templates
        else:
            active_templates = cls._load_templates(grade)

        if not active_templates:
            active_templates = cls.FALLBACK_TEMPLATES

        rng = random.Random(seed)
        selected = []
        for idx in range(max(1, count)):
            template = active_templates[idx % len(active_templates)]
            if template.get("params") or template.get("question_text") is not None:
                values = template.get("params") or {}
                selected.append(cls.render_question(template, values))
                continue

            values = cls._build_values(grade, template, rng)
            selected.append(cls.render_question(template, values))

        return selected

    @classmethod
    def render_question(cls, template: Dict[str, Any], values: Dict[str, Any]) -> Dict[str, Any]:
        if template.get("question_text") is not None and "correct_answer" in template:
            return {
                "question_text": template.get("question_text"),
                "correct_answer": str(template.get("correct_answer", "")),
                "hint": template.get("hint") or template.get("description") or "",
                "options": None,
                "params": template.get("params") or values,
                "template_id": template.get("template_id"),
            }

        formula = template.get("formula_template", "{a} + {b}")
        rendered_formula = formula.format(**values)
        answer_expression = template.get("answer_expression") or formula
        answer = cls._evaluate_expression(answer_expression, values)
        description = (template.get("description") or "Solve the math expression").strip()
        hint = cls._build_hint(description, rendered_formula, values)
        return {
            "question_text": f"What is {rendered_formula}?",
            "correct_answer": str(answer),
            "hint": hint,
            "options": None,
            "params": values,
            "template_id": template.get("template_id"),
        }

    @classmethod
    def _build_values(cls, grade: int, template: Dict[str, Any], rng: random.Random) -> Dict[str, Any]:
        if "formula_template" not in template:
            template = {"formula_template": "{a} + {b}"}

        if "×" in template.get("formula_template", ""):
            a = rng.randint(2, 12)
            b = rng.randint(2, 12)
            return {"a": a, "b": b}

        if "-" in template.get("formula_template", ""):
            a = rng.randint(5, 25)
            b = rng.randint(1, a)
            return {"a": a, "b": b}

        if "+" in template.get("formula_template", ""):
            lo = 1 if grade <= 2 else 10
            hi = 20 if grade <= 2 else 100
            a = rng.randint(lo, hi)
            b = rng.randint(lo, hi)
            return {"a": a, "b": b}

        a = rng.randint(2, 10)
        b = rng.randint(2, 10)
        return {"a": a, "b": b}

    @classmethod
    def _load_templates(cls, grade: int) -> List[Dict[str, Any]]:
        try:
            rows = qry(
                "EXEC dbo.usp_GetDynamicMathQuestions @grade_id = ?, @count = ?",
                (grade, 5),
                fetch="all",
            ) or []
            if rows:
                return [
                    {
                        "template_id": row.get("template_id"),
                        "formula_template": row.get("formula_template") or "{a} + {b}",
                        "answer_expression": row.get("answer_expression") or (row.get("correct_answer") if row.get("correct_answer") else "a + b"),
                        "description": row.get("description") or row.get("hint") or "Solve the math expression",
                        "question_text": row.get("question_text"),
                        "correct_answer": row.get("correct_answer"),
                        "hint": row.get("hint") or row.get("description"),
                        "params": row.get("params") or (json.loads(row.get("params_json", "{}")) if row.get("params_json") else {}),
                    }
                    for row in rows
                ]
        except Exception:
            return []
        return []

    @classmethod
    def _build_hint(cls, description: str, rendered_formula: str, values: Dict[str, Any]) -> str:
        desc = description.lower()
        if "add" in desc:
            return f"Add {values.get('a')} and {values.get('b')}."
        if "subtract" in desc or "minus" in desc:
            return f"Start at {values.get('a')} and count back {values.get('b')}."
        if "multiply" in desc or "times" in desc:
            return f"Think of {values.get('b')} groups of {values.get('a')}."
        return f"Evaluate {rendered_formula}."

    @classmethod
    def _evaluate_expression(cls, expression: str, values: Dict[str, Any]) -> Any:
        allowed_names = set(values.keys())
        tree = ast.parse(expression, mode="eval")

        def _eval(node: ast.AST) -> Any:
            if isinstance(node, ast.Expression):
                return _eval(node.body)
            if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
                return node.value
            if isinstance(node, ast.Name):
                if node.id not in allowed_names:
                    raise ValueError(f"Unsupported variable: {node.id}")
                return values[node.id]
            if isinstance(node, ast.BinOp):
                left = _eval(node.left)
                right = _eval(node.right)
                if isinstance(node.op, ast.Add):
                    return left + right
                if isinstance(node.op, ast.Sub):
                    return left - right
                if isinstance(node.op, ast.Mult):
                    return left * right
                if isinstance(node.op, ast.Div):
                    return left / right
                if isinstance(node.op, ast.FloorDiv):
                    return left // right
                if isinstance(node.op, ast.Mod):
                    return left % right
                if isinstance(node.op, ast.Pow):
                    return left ** right
            if isinstance(node, ast.UnaryOp):
                operand = _eval(node.operand)
                if isinstance(node.op, ast.UAdd):
                    return +operand
                if isinstance(node.op, ast.USub):
                    return -operand
            raise ValueError(f"Unsupported expression: {ast.dump(node)}")

        result = _eval(tree)
        if isinstance(result, float) and result.is_integer():
            return int(result)
        return result
