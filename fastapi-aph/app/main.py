from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import os

from app.shared.infrastructure.routes.router import router
from app.shared.infrastructure.middleware.auth_middleware import AuthMiddleware

# Load environment variables
load_dotenv()

app = FastAPI(
    title=os.getenv("APP_NAME", "FastAPI APH"),
    description="APH API built with FastAPI",
    version=os.getenv("APP_VERSION", "1.0.0"),
    debug=os.getenv("APP_DEBUG", "False").lower() == "true"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify allowed origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Add custom middleware
app.add_middleware(AuthMiddleware)

# Include all routes
app.include_router(router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)