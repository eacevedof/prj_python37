from vue.shared.domain.element_enum import ElementEnum


class TacticalRequestsAttributesRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_sel_request_reason(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[2]/div/div/div[2]/div/div/div/div/div[1]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[2]/div/div/div[2]/div/div/div/div/div[1]/div/div/div/div[3]/ul/li[2]"

    @staticmethod
    def get_sel_request_priority(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[2]/div/div/div[2]/div/div/div/div/div[3]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[2]/div/div/div[2]/div/div/div/div/div[3]/div/div/div/div[3]/ul/li[2]"

    @staticmethod
    def get_id_target_date() -> str:
        return "id-targetDate"

    @staticmethod
    def get_xpath_comment() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[2]/div/div/div[2]/div/div/div/div/div[4]/div/div[1]/textarea"

    @staticmethod
    def get_xpath_optional_comment() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div[3]/div/div[4]/div/div[2]/div[2]/div/div[1]/textarea"

    @staticmethod
    def get_xpath_btn_pais() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[2]/div/div[2]/div[1]/div/div/div[3]/div/div/div/div[1]/div[1]/div/div/button"

    @staticmethod
    def get_sel_categoria(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div[3]/div/div[2]/div/div[2]/div[2]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div[3]/div/div[2]/div/div[2]/div[2]/div/div/div/div[3]/ul/li[2]"

    @staticmethod
    def get_sel_pais(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div[3]/div/div[3]/div/div[2]/div[2]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div[3]/div/div[3]/div/div[2]/div[2]/div/div/div/div[3]/ul/li[4]"

    @staticmethod
    def get_sel_tmp(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return ""
        return ""
