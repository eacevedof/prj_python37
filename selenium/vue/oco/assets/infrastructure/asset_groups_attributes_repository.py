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
    def get_tab_production() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[2]"

    @staticmethod
    def get_tab_diseno() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[3]"

    @staticmethod
    def get_tab_datos_opcionales() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[4]"
