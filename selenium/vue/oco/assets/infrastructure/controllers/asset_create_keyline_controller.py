from vue.oco.assets.application.asset_create_keyline_service import asset_create_keyline


def __invoke() -> None:
    try:
        asset_create_keyline()
    except Exception as e:
        print(e)


__invoke()
