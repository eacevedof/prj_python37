from enum import Enum

class ModulePathEnum(Enum):
    WHATSAPP_SEND_TEXT_MESSAGE = "whatsapp.infrastructure.controllers.send_message_controller"
    CHAT_GPT_PDF_QUESTION = "modules.open_ai.infrastructure.controllers.talk_to_gpt35_controller"
    CHAT_GPT_ASK_QUESTION = "modules.open_ai.infrastructure.controllers.talk_to_gpt35_controller"
    HEALTH_CHECK = "modules.health_check.infrastructure.controllers.get_health_check_controller"
    DOCUMENTATION = "modules.api_doc.infrastructure.controllers.get_documentation_controller"