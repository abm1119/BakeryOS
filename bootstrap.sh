#!/bin/bash

echo "🍞 Bootstrapping Bakery OS..."

# 1. Create Python virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# 2. Install requirements
echo "Installing dependencies..."
cat << 'EOF' > requirements.txt
fastapi
uvicorn[standard]
sqlalchemy
asyncpg
greenlet
jinja2
python-multipart
celery
redis
alembic
EOF

pip install -r requirements.txt

# 3. Start Docker containers (PostgreSQL & Redis)
echo "Starting database and cache services..."
docker-compose up -d

echo "✅ Bootstrap complete! Phase 1 environment is ready."
echo "To activate the environment, run: source venv/bin/activate"
