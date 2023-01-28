from vue.shared.infrastructure.facades.env import *


class FilesRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_rnd_artworks() -> str:
        home = getenv(ENV_HOME)
        return f"{home}/Desktop/assets-1/mat-arch-opcionales-2-de-n.jpg"
