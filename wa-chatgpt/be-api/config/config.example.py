OPENAI_API_KEY = ":)"

META_BUSINESS_ID = ":)"
META_BUSINESS_BEARER_TOKEN = ":)"

PINECONE_SERVER = "https://yyy-xxxx.pinecone.io"
PINECONE_API_KEY = ":)"
PINECONE_INDEX_NAME = "pdf"

ENCRYPT_SALT = ":)"

GOOGLE_SEARCH_API = "https://serpapi.com/search"
GOOGLE_SEARCH_API_KEY = ":)"

import os
os.environ["PINECONE_API_KEY"] = PINECONE_API_KEY
os.environ["SERPAPI_API_KEY"] = GOOGLE_SEARCH_API_KEY