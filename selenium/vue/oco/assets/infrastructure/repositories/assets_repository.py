from vue.shared.domain.element_enum import ElementEnum


class AssetsRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_id_asset_code() -> str:
        return "id-asset-code"

    @staticmethod
    def get_id_asset_name() -> str:
        return "id-asset-name"

    @staticmethod
    def get_id_button_save() -> str:
        return "btnSaveAsset"
