# bizPharma Backend API

Python FastAPI modular monolith backend for bizPharma pharmacy management system.

## Setup

### Prerequisites
- Python 3.11+
- Firebase project with Admin SDK credentials

### Installation

1. **Create virtual environment:**
```bash
python -m venv venv
```

2. **Activate virtual environment:**
```bash
# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate
```

3. **Install dependencies:**
```bash
pip install -r requirements.txt
```

4. **Configure environment:**
```bash
cp .env.example .env
# Edit .env with your Firebase credentials
```

5. **Download Firebase Service Account Key:**
   - Go to Firebase Console → Project Settings → Service Accounts
   - Click "Generate New Private Key"
   - Save as `serviceAccountKey.json` in backend root

### Running the Server

```bash
# Development mode (with auto-reload)
python main.py

# Or using uvicorn directly
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Server will start at: `http://localhost:8000`

API documentation available at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## Project Structure

```
backend/
├── config/          # Configuration and settings
├── core/            # Core utilities (auth, database, exceptions)
├── modules/         # Business logic modules
│   ├── authentication/
│   ├── procurement/
│   ├── pricing/
│   ├── inventory/
│   ├── ai_intelligence/
│   ├── financial/
│   └── pos/
├── shared/          # Shared utilities
├── tests/           # Unit and integration tests
└── main.py          # Application entry point
```

## Development

### Testing
```bash
pytest
```

### Code Style
```bash
black .
isort .
flake8
```

## Next Steps

1. ✅ Project initialized
2. Configure Firebase credentials
3. Implement business logic modules
4. Add tests
5. Deploy to production
