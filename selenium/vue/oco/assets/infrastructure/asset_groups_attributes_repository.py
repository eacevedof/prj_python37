from vue.shared.domain.element_enum import ElementEnum

ASSETS_CREATION = {
    "mat-1": {
        "id-asset-code": "mat-1",
        "id-asset-name": "mat-1",
        "id-assetTypes": "id-assetTypes",
    },
}


class AssetGroupsAttributesRepository:
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

    @staticmethod
    def get_sel_asset_type(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[1]"
