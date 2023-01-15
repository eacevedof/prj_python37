from vue.assets.application.asset_create_service import asset_create_material


def __asset_create_material() -> None:
    try:
        asset_create_material()
    except Exception as e:
        print(e)


__asset_create_material()
