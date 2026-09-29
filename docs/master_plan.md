# Implementation Master Plan

Execute this plan sequentially. DO NOT move to the next phase until the current phase is fully functional, tested, and verified by the user.

## Phase 1: Foundation & Scaffolding
1. Generate `requirements.txt` with FastAPI, Uvicorn, SQLAlchemy, Asyncpg, Jinja2, Celery, and Redis.
2. Create the `docker-compose.yml` for PostgreSQL and Redis.
3. Scaffold the directory structure defined in `tech_stack.md`.
4. Write the SQLAlchemy models defined in `database_schema.md` in `app/models/`.
5. Create `app/core/db.py` to handle the async database engine and session maker.

## Phase 2: Core UI & HTMX Setup
1. Set up `app/main.py` with FastAPI, mount the static directory, and configure the Jinja2 templates directory.
2. Create `app/templates/base.html`. Include the Tailwind CDN (for development) and the HTMX CDN. Build a minimalist sidebar navigation (Dashboard, POS, Kitchen, Wholesale, Vendors).
3. Create a basic dashboard view and route it in `app/routers/web.py`.

## Phase 3: The POS Register (Multi-Currency)
1. Build `app/templates/pos.html`. It should have a product grid on the left and a cart/checkout pane on the right.
2. Implement HTMX endpoints in `app/routers/htmx_partials.py` for:
   - Clicking a product adds it to the server-side cart session and swaps the updated cart HTML into the DOM.
   - Selecting a currency from a dropdown recalculates the cart totals based on the `Currency` table rates and swaps the totals HTML.
3. Implement the checkout logic: Deduct stock, record the `Order`, and update the `Salesman` ledger if a wholesale order is unpaid.

## Phase 4: Internal ERP Modules
1. **Kitchen Log:** Build a UI for `LaborTeam` to submit a `ProductionBatch`. Use an HTMX form that updates the `Product.stock_qty` on submit.
2. **Wholesale Ledger:** Build a table displaying all `Salesmen` and their balances. Add an HTMX modal to log a partial payment and reduce their balance.
3. **Vendor Invoices:** Build a form to input external vendor bills. If marked as "Credit", increase the `Vendor` total payable balance.

## Phase 5: Celery Background Tasks
1. Initialize Celery in `app/core/celery_worker.py`.
2. Write a task to simulate fetching daily exchange rates and updating the `Currency` table.
3. Write a task that runs on End-of-Day checkout to aggregate total cash collected in base currency and clear the daily session logs.