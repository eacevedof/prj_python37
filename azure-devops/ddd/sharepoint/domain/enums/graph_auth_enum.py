from enum import Enum
from typing import final


@final
class GraphAuthEnum(str, Enum):
    """Microsoft Graph API OAuth2 authentication endpoints and scopes."""

    TOKEN_URL_TEMPLATE = (
        "https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token"
    )
    DEFAULT_SCOPE = "https://graph.microsoft.com/.default"
