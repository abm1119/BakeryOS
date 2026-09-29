# Project Context: Bakery OS (POS & ERP)

## Overview
We are building a lightweight, highly responsive Point of Sale (POS) and Enterprise Resource Planning (ERP) system tailored for a bakery operation. The system must unify retail walk-in sales, wholesale distribution, kitchen production, and vendor management.

## Core Entities & Business Logic
1. **Products:** 17+ core items (e.g., Bread, Cakes, Pastries). Each has a base retail price, a wholesale price, and current stock levels.
2. **Sales Channels:** 
   - **Retail (Walk-in):** Standard POS checkout. Paid immediately.
   - **Wholesale (Salesmen):** 10+ specific delivery salesmen. Checkout uses wholesale pricing and amounts are often credited to their running ledger/account balance.
3. **Labor & Production:** Kitchen staff (Labor Teams 1, 2, 3...) bake batches. Logging a batch (e.g., "Team A baked 200 Loaves") automatically increments product stock.
4. **Vendors & Invoices:** The bakery buys raw materials (flour, sugar) and ready-made items from vendors. Invoices can be marked as "Instant Cash" (paid from register) or "Credit" (accounts payable).
5. **Multi-Currency:** The base currency is PKR. The system must handle transactions and vendor bills in INR, USD, and AED, dynamically converting them at checkout and logging the exchange rate used.

## Design Philosophy
- **Minimalist & Fast:** The UI must be distraction-free. Cashiers need to check out customers in seconds.
- **Local-First Resiliency:** The system should be fast and capable of running smoothly on a local network even if external internet drops.