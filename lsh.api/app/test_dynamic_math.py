import os
import sys
import unittest
from unittest.mock import patch

sys.path.insert(0, os.path.dirname(__file__))

from services.dynamic_math import DynamicMathQuestionService


class DynamicMathQuestionServiceTests(unittest.TestCase):
    def test_render_question_from_formula_template(self):
        template = {
            "formula_template": "{a} + {b}",
            "answer_expression": "a + b",
            "description": "Add two numbers"
        }

        question = DynamicMathQuestionService.render_question(template, {"a": 2, "b": 3})

        self.assertEqual(question["question_text"], "What is 2 + 3?")
        self.assertEqual(question["correct_answer"], "5")
        self.assertEqual(question["hint"], "Add 2 and 3.")

    def test_generate_questions_uses_requested_count(self):
        templates = [
            {"formula_template": "{a} + {b}", "answer_expression": "a + b", "description": "Add"},
            {"formula_template": "{a} - {b}", "answer_expression": "a - b", "description": "Subtract"},
        ]

        questions = DynamicMathQuestionService.generate_questions(2, 2, templates=templates, seed=7)

        self.assertEqual(len(questions), 2)
        self.assertTrue(all("question_text" in q for q in questions))
        self.assertTrue(all("correct_answer" in q for q in questions))

    @patch("services.dynamic_math.qry")
    def test_get_db_questions_returns_sql_rows_when_available(self, mock_qry):
        mock_qry.return_value = [
            {
                "template_id": 1,
                "question_text": "What is 2 + 3?",
                "correct_answer": "5",
                "hint": "Add 2 and 3.",
                "params_json": '{"a": 2, "b": 3}',
            },
        ]

        questions = DynamicMathQuestionService.get_db_questions(2, 1)

        self.assertEqual(len(questions), 1)
        self.assertEqual(questions[0]["question_text"], "What is 2 + 3?")
        self.assertEqual(questions[0]["correct_answer"], "5")

    @patch("services.dynamic_math.qry")
    def test_generate_questions_uses_db_rows_when_available(self, mock_qry):
        mock_qry.return_value = [
            {
                "template_id": 1,
                "question_text": "What is 2 + 3?",
                "correct_answer": "5",
                "hint": "Add 2 and 3.",
                "params_json": '{"a": 2, "b": 3}',
            },
        ]

        questions = DynamicMathQuestionService.generate_questions(2, 1, seed=3)

        self.assertEqual(len(questions), 1)
        self.assertEqual(questions[0]["question_text"], "What is 2 + 3?")
        self.assertEqual(questions[0]["correct_answer"], "5")


if __name__ == "__main__":
    unittest.main()
