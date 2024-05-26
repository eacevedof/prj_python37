class VersionsDto:
    def __init__(self, version: str):
        self._version = version

    @property
    def version(self):
        return self._version

    def to_dict(self) -> dict:
        return {
            "version": self._version,
        }