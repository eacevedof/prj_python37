from enum import Enum

class HttpRouteEnum(Enum):
    WHATSAPP_SEND_TEXT_MESSAGE = "/api/v1/whatsapp/send-text-message"
    CHAT_GPT_PDF_QUESTION = "/api/v1/chat-gpt/pdf-question"
    CHAT_GPT_ASK_QUESTION = "/api/v1/chat-gpt/ask"
    HEALTH_CHECK = "/api/v1/health-check"
    DOCUMENTATION = "/"