from typing import final

from ddd.open_ai.domain.enums import (
    OpenaiChatConstraintsEnum,
    OpenaiChatModelEnum,
    OpenaiChatRoleEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException


@final
class ChatCompletionInputValidatorService:
    """Servicio de dominio: valida los parámetros de un chat completion."""

    @staticmethod
    def fail_if_wrong_input(
        messages: list[dict[str, str]],
        model: str,
        temperature: float,
        max_tokens: int,
    ) -> None:
        if not messages:
            OpenAIException.bad_request("messages cannot be empty")

        valid_models = list(OpenaiChatModelEnum)
        if model not in valid_models:
            OpenAIException.bad_request(
                f"Invalid model: {model}. Allowed values: {', '.join(valid_models)}"
            )

        min_temperature = OpenaiChatConstraintsEnum.MIN_TEMPERATURE
        max_temperature = OpenaiChatConstraintsEnum.MAX_TEMPERATURE
        if not min_temperature <= temperature <= max_temperature:
            OpenAIException.bad_request(
                f"Temperature must be between {min_temperature} and {max_temperature}"
            )

        max_tokens_limit = OpenaiChatConstraintsEnum.MAX_TOKENS_LIMIT
        if max_tokens > max_tokens_limit:
            OpenAIException.bad_request(f"max_tokens cannot exceed {max_tokens_limit}")

        valid_roles = list(OpenaiChatRoleEnum)
        for message in messages:
            if "role" not in message or "content" not in message:
                OpenAIException.bad_request("each message must have 'role' and 'content' keys")

            role = message.get("role", "")
            if role not in valid_roles:
                OpenAIException.bad_request(
                    f"Invalid role '{role}'. Allowed values: {', '.join(valid_roles)}"
                )

            if not str(message.get("content", "")).strip():
                OpenAIException.bad_request("Message content cannot be empty")
