# FastAPI APH API

A Python FastAPI implementation of the APH microservice, migrated from Deno/TypeScript with hexagonal architecture principles.

## 🏗️ Architecture

This project follows **Hexagonal Architecture** (Ports and Adapters) principles:

```
app/
├── modules/                    # Business modules
│   ├── authenticator/         # Authentication & authorization
│   ├── users/                 # User management
│   ├── devops/                # System monitoring & health
│   ├── mailing/               # Email functionality
│   ├── documentation/         # API documentation
│   ├── healthcheck/           # Health check endpoints
│   └── static_assets/         # Static files (CSS, JS, images)
└── shared/                    # Shared components
    ├── domain/                # Domain exceptions & entities
    └── infrastructure/        # HTTP, logging, middleware
```

Each module follows the structure:
- `application/` - Use cases and business logic
- `domain/` - Domain entities, exceptions, enums
- `infrastructure/` - Controllers, repositories, external integrations

## 🚀 Getting Started

### Prerequisites

- Python 3.11+
- Docker & Docker Compose (optional)

### Local Development

1. **Clone and setup:**
```bash
cd /projects/tmp/py-fast-api
python -m venv venv
source venv/bin/activate  # On Windows: venv\\Scripts\\activate
pip install -r requirements.txt
```

2. **Configure environment:**
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. **Start the application:**
```bash
./start.sh
# Or manually: uvicorn app.main:app --reload
```

4. **Access the API:**
- API: http://localhost:8123
- Documentation: http://localhost:8123/docs
- Health Check: http://localhost:8123/health
- API Docs: http://localhost:8123/ (custom documentation)

### Docker Development

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f api

# Stop services
docker-compose down
```

## 📡 API Endpoints

### Core Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | API Documentation | No |
| GET | `/changelog` | API Changelog | No |
| GET | `/health` | Health Check | No |
| POST | `/v1/users/create-user` | Create User | Yes |
| GET | `/devops/check-app` | System Status | No |

### Authentication

All protected endpoints require the `lzrmsaph-auth` header:

```bash
curl -H "lzrmsaph-auth: YOUR_TOKEN" \
     -H "Content-Type: application/json" \
     http://localhost:8123/v1/users/create-user
```

## 🔧 Configuration

### Environment Variables

```bash
# Application
APP_ENV=development
APP_NAME=py-fast-api
APP_VERSION=1.0.0
APP_DEBUG=True

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# Redis
REDIS_URL=redis://localhost:6379/0

# SMTP
SMTP_HOST=smtp.serviciodecorreo.es
SMTP_PORT=465
SMTP_USERNAME=no-reply@cyberscp.es
SMTP_PASSWORD=your_password
SMTP_USE_TLS=true

# Security
JWT_SECRET_KEY=your-secret-key
APP_AUTH_TOKEN=LZRMSAPH-APP-your-token
```

## 🧪 Testing

```bash
# Install test dependencies
pip install pytest pytest-asyncio httpx

# Run tests
pytest

# Run with coverage
pytest --cov=app
```

## 🐳 Production Deployment

### Docker

```bash
# Build production image
docker build -t fastapi-antiphishing .

# Run production container
docker run -d \
  --name antiphishing-api \
  -p 8123:8123 \
  --env-file .env \
  fastapi-antiphishing
```

### Manual Deployment

```bash
# Install dependencies
pip install -r requirements.txt

# Start with Gunicorn
gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker
```

## 📋 Available Modules

- ✅ **Authenticator** - Token-based authentication
- ✅ **Users** - User creation and management  
- ✅ **Devops** - System monitoring and health checks
- ✅ **Mailing** - Email functionality with CURL/SMTP
- ✅ **Documentation** - API documentation and changelog
- ✅ **HealthCheck** - Service health monitoring
- ✅ **StaticAssets** - CSS, JS, and image serving

## 🔄 Migration from Deno/TypeScript

This FastAPI implementation maintains the same:
- API endpoints and responses
- Business logic and use cases
- Hexagonal architecture principles
- Authentication mechanisms

Key differences:
- Python/FastAPI instead of Deno/TypeScript
- Pydantic models instead of TypeScript interfaces
- Python async/await patterns
- FastAPI automatic OpenAPI documentation

## 🤝 Contributing

1. Follow Python PEP 8 style guidelines
2. Use snake_case for functions and variables
3. Maintain hexagonal architecture principles
4. Add type hints to all functions
5. Write docstrings for public methods
6. Update tests for any changes

## 📝 License

This project is part of the Lazarus Tech APH infrastructure.

---

**Note:** This is a Python/FastAPI port of the original Deno/TypeScript APH microservice, maintaining compatibility with existing clients while leveraging Python's ecosystem and FastAPI's performance.