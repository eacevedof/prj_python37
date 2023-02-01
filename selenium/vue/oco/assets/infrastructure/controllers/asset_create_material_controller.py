from vue.oco.assets.application.asset_create_material_service import asset_create_material


def __invoke() -> None:
    try:
        asset_create_material()
    except Exception as e:
        print(e)


__invoke()
