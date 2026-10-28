import base64
import json
from typing import final, Self, Any


@final
class Encoder:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_array_as_base64_encoded(self, data: dict[str, Any] | list[Any]) -> str:
        json_string = json.dumps(data)
        return self.get_base64_encoded(json_string)

    def get_decoded_array_from_base64(self, base64_encoded: str) -> dict[str, Any] | list[Any]:
        decoded_string = self.get_base64_decoded(base64_encoded)
        if decoded_string:
            try:
                return json.loads(decoded_string)
            except json.JSONDecodeError:
                pass
        return {}

    def get_base64_encoded(self, text: str) -> str:
        return base64.b64encode(text.encode("utf-8")).decode("utf-8")

    def get_base64_decoded(self, base64_encoded: str) -> str:
        try:
            return base64.b64decode(base64_encoded).decode("utf-8")
        except Exception:
            return base64_encoded
