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
    def get_sel_maquina(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[1]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[1]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_sel_plano_propio(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_xpath_descripcion() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[3]/div/div/input"

    @staticmethod
    def get_sel_tipo_plano(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_sel_prospecto_doblado(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[5]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[5]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_xpath_medida_a() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[1]/div/div/input"

    @staticmethod
    def get_xpath_medida_b() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[2]/div/div/input"

    @staticmethod
    def get_xpath_medida_c() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[3]/div/div/input"

    @staticmethod
    def get_xpath_medida_d() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[4]/div/div/input"

    @staticmethod
    def get_xpath_capacidad() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[5]/div/div/input"

    @staticmethod
    def get_xpath_diametro() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div[6]/div/div/input"

    @staticmethod
    def get_xpath_comentarios_opcionales() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div/div/div[1]/textarea"
