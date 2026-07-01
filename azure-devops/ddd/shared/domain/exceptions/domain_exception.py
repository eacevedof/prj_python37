class DomainException(Exception):
    """Base class for all domain-level exceptions.

    Domain exceptions carry a human-readable ``message`` (also returned by
    ``str(e)``) and an HTTP-style ``code`` so MCP controllers can surface the
    message safely to clients, unlike infrastructure errors.
    """

    def __init__(self, message: str, code: int = 400) -> None:
        self.message = message
        self.code = code
        super().__init__(message)
