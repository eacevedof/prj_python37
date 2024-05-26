class VersionsDto:
    def __init__(self, username, password):
        self._username = username
        self._password = password

    @property
    def username(self):
        return self._username

    @property
    def password(self):
        return self._password

    def to_dict(self):
        return {
            "username": self._username,
            "password": self._password
        }