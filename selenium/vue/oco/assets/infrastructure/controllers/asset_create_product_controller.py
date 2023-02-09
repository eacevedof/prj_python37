from vue.oco.assets.application.asset_create_product_service import asset_create_product


def __invoke() -> None:
    try:
        asset_create_product()
    except Exception as e:
        print(e)


__invoke()
