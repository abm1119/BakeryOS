# Implementation Master Plan: Bakery OS

## Project Context
This document outlines the step-by-step execution phases to build a lightweight, offline-resilient POS and ERP system. The target deployment environment is Khalid Bakers and Brothers, requiring rapid on-premises checkout for walk-in retail, Khairpur-based wholesale distribution ledgers, and multi-currency support.

## Execution Rules for AI Agent
1. **Sequential Execution:** Complete each phase fully, including testing, before moving to the next.
2. **HTMX Strictness:** Do not use React, Vue, or any client-side JS framework. All dynamic UI updates must use HTMX attributes (`hx-get`, `hx-post`, `hx-swap`) swapping Jinja2 server-rendered HTML partials.
3. **Styling:** Use standalone Tailwind CSS utility classes exclusively.
4. **Data Integrity:** All multi-currency transactions must anchor to the base currency (PKR).

---

## Phase 1: Environment & Database Scaffolding
- [ ] Initialize Python virtual environment and install dependencies (`fastapi`, `uvicorn`, `sqlalchemy`, `asyncpg`, `jinja2`, `celery`, `redis`).
- [ ] Set up the `docker-compose.yml` file to spin up PostgreSQL and Redis containers.
- [ ] Construct the project directory structure (`app/core`, `app/models`, `app/routers`, `app/templates`, `app/tasks`).
- [ ] Configure `app/core/db.py` to establish an asynchronous SQLAlchemy engine and session maker connected to the PostgreSQL container.

## Phase 2: Data Modeling (PostgreSQL + SQLAlchemy)
- [ ] Create `Currency` model (code, symbol, is_base, exchange_rate_to_base).
- [ ] Create `Product` model (name, retail_price, wholesale_price, stock_qty, unit).
- [ ] Create `Salesman` (wholesale agents) and `Vendor` (suppliers) ledger models.
- [ ] Create `Order` and `OrderItem` models with multi-currency tracking fields (base_total, tender_currency, exchange_rate_used).
- [ ] Create `ProductionBatch` (kitchen labor output) and `VendorInvoice` models.
- [ ] Generate and apply Alembic migrations to build the initial schema.

## Phase 3: Core API & HTMX Scaffolding
- [ ] Set up the main FastAPI instance in `app/main.py`.
- [ ] Configure Jinja2 templates directory and mount static files (for Tailwind CSS and `htmx.min.js`).
- [ ] Build `base.html` containing the global layout, Tailwind CDN (or compiled output), HTMX script, and navigation sidebar (Dashboard, POS, Kitchen, Wholesale, Vendors).
- [ ] Create basic routing in `app/routers/web.py` to serve the initial dashboard view.

## Phase 4: POS Register & Checkout Module
- [ ] Build `pos.html` featuring a split-pane layout: Product Grid (left) and Cart/Checkout (right).
- [ ] Implement HTMX partials (`app/routers/htmx_partials.py`): 
    - Click product -> Server updates cart session -> Swaps new cart HTML.
    - Currency Dropdown change -> Server recalculates cart totals (PKR to INR/USD/AED) -> Swaps totals HTML.
- [ ] Implement Checkout POST route: Deduct `Product.stock_qty`, record `Order`, and update `Salesman` ledger if checked out as unpaid wholesale.

## Phase 5: ERP Modules (Labor, Inventory & Vendors)
- [ ] **Kitchen Batch Logger:** Build a UI form where labor teams input daily production yields. Form submission must instantly increment `Product.stock_qty`.
- [ ] **Wholesale Ledgers:** Build a table displaying all 10+ wholesale salesmen. Implement an inline HTMX modal to record partial or full balance payments.
- [ ] **Vendor Invoices:** Build a data entry form for supplier bills, allowing selection of Instant Cash (updates daily cash metrics) or Credit (updates Vendor payable ledger).

## Phase 6: Asynchronous Processing (Celery)
- [ ] Initialize Celery application in `app/core/celery_worker.py` connected to Redis.
- [ ] Write a periodic task (`celery beat`) to fetch and update daily exchange rates for PKR, INR, USD, and AED.
- [ ] Write a background task for End-of-Day (EOD) register closing, calculating daily revenue, converting foreign cash tenders to base PKR totals, and wiping active cart sessions.