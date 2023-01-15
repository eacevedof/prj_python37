from vue.assets.application.asset_create_service import asset_create


def __invoke() -> None:
    try:
        asset_create()
    except Exception as e:
        print(e)


__invoke()
