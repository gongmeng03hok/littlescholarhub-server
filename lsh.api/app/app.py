"""
Little Scholars Hub — Flask Application Entry Point
Run: python app.py  |  gunicorn "app:create_app()"
"""

from flask import Flask, jsonify
from flask_cors import CORS
from datetime import datetime
import os
from dotenv import load_dotenv
load_dotenv()

from routes.auth            import auth_bp
from routes.children        import children_bp
from routes.assessment      import assessment_bp
from routes.questions       import questions_bp
from routes.content         import content_bp
from routes.progress        import progress_bp
from routes.admin           import admin_bp
from routes.config          import config_bp
from routes.recommendations import recommendations_bp
from routes.math_weekly     import math_weekly_bp
from routes.math_pdf        import math_pdf_bp
from routes.teacher         import teacher_bp
from routes.homework        import homework_bp
from routes.community       import community_bp
from routes.gamification    import gamification_bp
from routes.rewards         import rewards_bp

from utils.db               import close_db
from utils.errors           import register_error_handlers


def create_app():
    app = Flask(__name__)

    CORS(app, resources={r"/api/*": {"origins": "*"}})

    _DEFAULT_SECRET = "change-me-in-production"
    jwt_secret = os.getenv("JWT_SECRET", "")
    if not jwt_secret or jwt_secret == _DEFAULT_SECRET:
        if os.getenv("FLASK_ENV") == "production":
            raise RuntimeError(
                "JWT_SECRET is missing or set to the insecure default. "
                "Set a strong JWT_SECRET (e.g. `openssl rand -hex 32`) before starting."
            )
        import warnings
        warnings.warn("JWT_SECRET not set — using an insecure development-only default.")
        jwt_secret = jwt_secret or _DEFAULT_SECRET
    app.config["JWT_SECRET"] = jwt_secret
    app.config["DB_CONN"]    = os.getenv("DB_CONN", "")
    app.config["MAX_CONTENT_LENGTH"] = 25 * 1024 * 1024  # 25MB upload cap

    app.teardown_appcontext(close_db)
    register_error_handlers(app)

    # ── Blueprints ───────────────────────────────────────────
    app.register_blueprint(auth_bp,            url_prefix="/api/auth")
    app.register_blueprint(children_bp,        url_prefix="/api/children")
    app.register_blueprint(assessment_bp,      url_prefix="/api/assessment")
    app.register_blueprint(questions_bp,       url_prefix="/api/questions")
    app.register_blueprint(content_bp,         url_prefix="/api/content")
    app.register_blueprint(progress_bp,        url_prefix="/api/progress")
    app.register_blueprint(admin_bp,           url_prefix="/api/admin")
    app.register_blueprint(config_bp,          url_prefix="/api/config")   # NEW
    app.register_blueprint(recommendations_bp, url_prefix="/api/recommendations")
    app.register_blueprint(math_weekly_bp,     url_prefix="/api/math")
    app.register_blueprint(math_pdf_bp,        url_prefix="/api/math/pdf")
    app.register_blueprint(teacher_bp,         url_prefix="/api/teacher")
    app.register_blueprint(homework_bp,        url_prefix="/api/homework")
    app.register_blueprint(community_bp,       url_prefix="/api/community")
    app.register_blueprint(gamification_bp,    url_prefix="/api/gamification")
    app.register_blueprint(rewards_bp,         url_prefix="/api/rewards")

    @app.get("/api/health")
    def health():
        return jsonify({"status": "ok", "ts": datetime.utcnow().isoformat()})

    return app


if __name__ == "__main__":
    create_app().run(debug=True, port=5000)
