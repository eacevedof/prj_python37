from vue.shared.domain.element_enum import ElementEnum


class TacticalRequestsRepository:
    def __int__(self):
        pass

    @staticmethod
    def get_sel_request_type_new_dev(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[1]/div/div/div[1]/div[1]/div/div/div/div[2]/button"
        # new development
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[1]/div/div/div[1]/div[1]/div/div/div/div[3]/ul/li[2]"

    @staticmethod
    def get_sel_request_type_material_modify(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[1]/div/div/div[1]/div[1]/div/div/div/div[2]/button"
        # material modification
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div[1]/div/div/div[1]/div[1]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_sel_asset(xpath: str = ElementEnum.BUTTON_XPATH) -> str:
        if xpath == ElementEnum.BUTTON_XPATH:
            return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[1]/div[2]/div/div/div/div[2]/button"
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[1]/div[2]/div/div/div/div[3]/ul/li[1]"

    @staticmethod
    def get_xpath_button_save() -> str:
        return "/html/body/div[1]/main/div/div[1]/div[3]/section/div[1]/div[1]/div[2]/div/div[2]/button"
