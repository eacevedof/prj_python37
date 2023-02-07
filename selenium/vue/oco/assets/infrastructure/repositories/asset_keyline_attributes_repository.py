from vue.shared.domain.element_enum import ElementEnum


class AssetKeylineAttributesRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_sel_asset_type_material(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[1]"
    @staticmethod
    def get_sel_asset_type_keyline(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[3]"

    @staticmethod
    def get_xpath_material_code() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[1]/div/div/input"

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
    def get_xpath_dosis() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[5]/div/div/input"

    @staticmethod
    def get_xpath_presentation() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[6]/div/div/input"

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

    @staticmethod
    def get_sel_fabricant(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[10]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[10]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_xpath_principio_activo() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[11]/div/div/input"

    @staticmethod
    def get_xpath_nomenclatura_extra() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[12]/div/div/input"

    @staticmethod
    def get_xpath_numero_de_tintas() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[1]/div/div/input"

    @staticmethod
    def get_xpath_acabados_especiales() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[2]/div/div/input"

    @staticmethod
    def get_xpath_laetus() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[1]/div/div/input"

    @staticmethod
    def get_sel_marcas_visuales(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[2]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[2]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_xpath_referencia_al_libro() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[3]/div/div/input"

    @staticmethod
    def get_xpath_comentarios_opcionales() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[4]/div/div/div/div/div[1]/textarea"
