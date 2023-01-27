from vue.shared.domain.element_enum import ElementEnum

ASSETS_CREATION = {
    "mat-1": {
        "id-asset-code": "mat-1",
        "id-asset-name": "mat-1",
        "id-assetTypes": "id-assetTypes",
    },
}


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
