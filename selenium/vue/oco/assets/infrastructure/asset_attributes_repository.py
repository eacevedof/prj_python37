from vue.shared.domain.element_enum import ElementEnum

ASSETS_CREATION = {
    "mat-1": {
        "id-asset-code": "mat-1",
        "id-asset-name": "mat-1",
        "id-assetTypes": "id-assetTypes",
    },
}


class AssetAttributesRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_sel_asset_type(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_id_material_code() -> str:
        return "id-Código Material - Versión"

    @staticmethod
    def get_sel_category(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[3]/ul/li[1]"
    @staticmethod
    def get_sel_type(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[3]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[3]/div/div/div/div[3]/ul/li[1]"
    @staticmethod
    def get_sel_lab_form(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_id_dosis() -> str:
        return "id-Dosis"

    @staticmethod
    def get_id_presentation() -> str:
        return "id-Presentación"

    @staticmethod
    def get_sel_market(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[7]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[7]/div/div/div/div[3]/ul/li[2]"

    @staticmethod
    def get_sel_client(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[8]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[8]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_sel_country(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[9]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[9]/div/div/div/div[3]/ul/li[3]"

    def get_sel_fabricant(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[10]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[10]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_id_principio_activo() -> str:
        return "id-Principio Activo"\

    @staticmethod
    def get_id_nomenclatura_extra() -> str:
        return "id-Nomenclatura Extra"