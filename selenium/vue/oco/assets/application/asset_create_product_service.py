from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.shared.infrastructure.facades.dropdown import Dropdown
from vue.shared.infrastructure.facades.element import Element
from vue.shared.infrastructure.generators.uuid import get_uuid
from vue.shared.infrastructure.repositories.routes_repository import RoutesRepository

from vue.shared.domain.element_enum import ElementEnum
from vue.oco.login.application.login_service import login_usr1_or_fail
from vue.oco.assets.infrastructure.repositories.assets_repository import AssetsRepository
from vue.oco.assets.infrastructure.repositories.asset_material_attributes_repository import \
    AssetMaterialAttributesRepository


def asset_create_product() -> None:
    login_usr1_or_fail()
    sleep(30)

    browser = get_chrome()
    browser.get(RoutesRepository.get_asset_add_url())
    dom = Dom(browser)
    sleep(3)

    __config_asset_type(dom)

    btn_id = AssetsRepository.get_id_button_save()
    btn_save = dom.find_by_id(btn_id)
    btn_save.click()
    close(30)


def __config_asset_type(dom: Dom) -> None:
    el = Element(dom)
    element_id = AssetsRepository.get_id_asset_code()
    uuid = get_uuid(4)
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    element_id = AssetsRepository.get_id_asset_name()
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)
    # tipo de asset
    btn_xpath = AssetMaterialAttributesRepository.get_sel_asset_type_material()
    li_xpath = AssetMaterialAttributesRepository.get_sel_asset_type_material(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
