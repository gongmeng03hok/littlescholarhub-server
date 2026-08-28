"""
services/email_service.py
Lightweight email helper (uses smtplib).
Configure via environment variables; silently skips in dev if not configured.
"""

import os
import smtplib
import logging
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

logger = logging.getLogger(__name__)

SMTP_HOST     = os.getenv("SMTP_HOST", "")
SMTP_PORT     = int(os.getenv("SMTP_PORT", "587"))
SMTP_USER     = os.getenv("SMTP_USER", "")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "")
FROM_ADDRESS  = os.getenv("FROM_EMAIL", "noreply@littlescholarshub.com")
APP_NAME      = "Little Scholars Hub"


def _send(to: str, subject: str, html_body: str) -> bool:
    """Send an email; returns True on success, False on any failure."""
    if not SMTP_HOST or not SMTP_USER:
        logger.debug("Email not configured – skipping send to %s: %s", to, subject)
        return False
    try:
        msg = MIMEMultipart("alternative")
        msg["Subject"] = subject
        msg["From"]    = f"{APP_NAME} <{FROM_ADDRESS}>"
        msg["To"]      = to
        msg.attach(MIMEText(html_body, "html"))

        with smtplib.SMTP(SMTP_HOST, SMTP_PORT, timeout=10) as server:
            server.ehlo()
            server.starttls()
            server.login(SMTP_USER, SMTP_PASSWORD)
            server.sendmail(FROM_ADDRESS, to, msg.as_string())
        return True
    except Exception as exc:
        logger.error("Email send failed: %s", exc)
        return False


def send_welcome(to: str, referral_code: str) -> bool:
    html = f"""
    <div style="font-family:sans-serif;max-width:560px;margin:auto">
      <h2 style="color:#5b4fcf">🌟 Welcome to Little Scholars Hub!</h2>
      <p>Thank you for joining. Your family's learning journey starts now.</p>
      <p>Your referral code: <strong>{referral_code}</strong></p>
      <p>Next step: <a href="https://littlescholarshub.com/children">Add your first child →</a></p>
      <hr/>
      <p style="color:#888;font-size:12px">Little Scholars Hub · TK–6 Enrichment Platform</p>
    </div>
    """
    return _send(to, f"Welcome to {APP_NAME}! 🌟", html)


def send_password_reset(to: str, reset_url: str) -> bool:
    html = f"""
    <div style="font-family:sans-serif;max-width:560px;margin:auto">
      <h2 style="color:#5b4fcf">🔑 Reset your password</h2>
      <p>We got a request to reset the password for this Little Scholars Hub account.</p>
      <p><a href="{reset_url}" style="background:#5b4fcf;color:white;padding:10px 20px;
         border-radius:6px;text-decoration:none">Reset my password →</a></p>
      <p style="color:#888;font-size:13px">This link expires in 1 hour. If you didn't request this,
         you can safely ignore this email — your password won't change.</p>
      <hr/>
      <p style="color:#888;font-size:12px">Little Scholars Hub</p>
    </div>
    """
    return _send(to, f"Reset your {APP_NAME} password", html)


def send_weekly_plan(to: str, child_name: str, plan_url: str) -> bool:
    html = f"""
    <div style="font-family:sans-serif;max-width:560px;margin:auto">
      <h2 style="color:#5b4fcf">📅 {child_name}'s Weekly Plan is Ready!</h2>
      <p>A fresh personalised study plan has been generated for this week.</p>
      <p><a href="{plan_url}" style="background:#5b4fcf;color:white;padding:10px 20px;
         border-radius:6px;text-decoration:none">View Plan →</a></p>
      <hr/>
      <p style="color:#888;font-size:12px">Little Scholars Hub</p>
    </div>
    """
    return _send(to, f"📅 {child_name}'s new weekly plan is ready!", html)


def send_streak_milestone(to: str, child_name: str, streak: int) -> bool:
    milestones = {7: "one whole week", 30: "30 days", 100: "100 days"}
    label = milestones.get(streak, f"{streak} days")
    html = f"""
    <div style="font-family:sans-serif;max-width:560px;margin:auto">
      <h2 style="color:#f59e0b">🔥 {child_name} is on a {streak}-day streak!</h2>
      <p>Amazing! {child_name} has been learning for {label} in a row.</p>
      <p>Keep the momentum going!</p>
      <hr/>
      <p style="color:#888;font-size:12px">Little Scholars Hub</p>
    </div>
    """
    return _send(to, f"🔥 {child_name} hit a {streak}-day streak!", html)
