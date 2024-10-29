from enum import Enum

class HttpRouteEnum(Enum):
    WHATSAPP_SEND_TEXT_MESSAGE = "/api/v1/whatsapp/send-text-message"

    CHAT_GPT_PDF_QUESTION = "/api/v1/chat-gpt/ask-your-pdf"
    CHAT_GPT_ASK_QUESTION = "/api/v1/chat-gpt/ask"

    USERS_CREATE_USER = "/api/v1/users/create"

    HEALTH_CHECK = "/api/v1/health-check"
    DOCUMENTATION = "/"