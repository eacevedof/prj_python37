from enum import Enum


class ControllerModuleEnum(Enum):
    WHATSAPP_SEND_TEXT_MESSAGE = "whatsapp.infrastructure.controllers.send_message_controller"

    CHAT_GPT_PDF_QUESTION = "modules.open_ai.infrastructure.controllers.ask_your_pdf_controller"
    CHAT_GPT_ASK_QUESTION = "modules.open_ai.infrastructure.controllers.talk_to_gpt35_controller"

    USERS_CREATE_USER = "modules.users.infrastructure.controllers.create_user_controller"
    USERS_UPDATE_USER = "modules.users.infrastructure.controllers.update_user_controller"

    HEALTH_CHECK = "modules.health_check.infrastructure.controllers.get_health_check_controller"
    DOCUMENTATION = "modules.api_doc.infrastructure.controllers.get_documentation_controller"

    LANG_CHAIN_ASK_QUESTION = "modules.lang_chain.infrastructure.controllers.lc_ask_question_controller"
    TALK_DB_ASK_PLATFORM = "modules.talk_db.infrastructure.controllers.ask_platform_controller"
