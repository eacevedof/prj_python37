from vue.shared.infrastructure.factories.driver_factory import FRONT_URL_HASH


class RoutesRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_asset_add_url() -> str:
        return f"{FRONT_URL_HASH}/assets/add"

    @staticmethod
    def get_tactical_requests_add_url() -> str:
        return f"{FRONT_URL_HASH}/requests/add"
