# Database Schema Requirements

Use SQLAlchemy to define the following asynchronous models. Ensure relationships are properly mapped.

## 1. Currency & Exchange Rates
- `Currency`: code (PKR, INR, USD - PK), symbol, is_base (Boolean), exchange_rate_to_base (Float).

## 2. Entities
- `Product`: id, name, retail_price (Float), wholesale_price (Float), stock_qty (Integer), unit (String).
- `Salesman`: id, name, phone, current_ledger_balance (Float).
- `Vendor`: id, name, contact_info, total_payable_balance (Float).
- `LaborTeam`: id, name (e.g., "Shift 1", "Shift 2").

## 3. Transactions & Operations
- `Order`: id, type (Enum: Retail, Wholesale), salesman_id (FK, nullable), base_currency_total, tender_currency (FK), exchange_rate_used, amount_paid, status (Paid, Unpaid, Partial), created_at.
- `OrderItem`: id, order_id (FK), product_id (FK), qty, unit_price_applied.
- `ProductionBatch`: id, product_id (FK), team_id (FK), qty_produced, created_at.
- `VendorInvoice`: id, vendor_id (FK), invoice_number, currency_code (FK), exchange_rate_used, total_amount, status (Paid, Credit), created_at.
- `InvoiceItem`: id, invoice_id (FK), description, qty, unit_cost.

## Logic Constraints
- `Order` total must be calculated dynamically based on `OrderItem` rows.
- Creating a `ProductionBatch` must immediately increment `Product.stock_qty`.
- Creating an `Order` must immediately decrement `Product.stock_qty`.