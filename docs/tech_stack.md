# Technology Stack & Architecture Guidelines

## Core Stack
- **Backend:** Python 3.11+, FastAPI
- **Database:** PostgreSQL (using SQLAlchemy as the ORM, async driver `asyncpg`)
- **Background Tasks:** Celery + Redis (Message Broker)
- **Frontend UI:** HTMX (for dynamic SPA-like interactions without JS frameworks)
- **Styling:** Tailwind CSS (Standalone CLI, no Node.js/npm required)
- **Templating:** Jinja2

## Strict AI Agent Coding Rules
1. **NO JAVASCRIPT FRAMEWORKS:** Do not use React, Vue, or Angular. Do not write JSON REST APIs for the frontend.
2. **HTMX PATTERNS:** The frontend must rely exclusively on HTMX attributes (`hx-get`, `hx-post`, `hx-target`, `hx-swap`). FastAPI endpoints must return rendered Jinja2 HTML snippets (partials), NOT JSON, for frontend interactions.
3. **TAILWIND ONLY:** Use pure Tailwind utility classes for all styling. No external CSS files unless absolutely necessary.
4. **ASYNC EVERYTHING:** Use asynchronous SQLAlchemy (`AsyncSession`) and async FastAPI endpoints (`async def`).

## Directory Structure
Enforce this project structure:
bakery_os/
├── app/
│   ├── main.py                 # FastAPI entry point
│   ├── core/                   # Config, DB connection, Celery init
│   ├── models/                 # SQLAlchemy ORM models
│   ├── routers/                # FastAPI routers (web.py for HTMX, htmx_partials.py)
│   ├── tasks/                  # Celery worker tasks
│   ├── templates/              # Jinja2 templates (pages and partials)
│   └── static/                 # CSS output, JS libraries (htmx.min.js)
├── docker-compose.yml          # Postgres & Redis services
└── requirements.txt            # Python dependencies