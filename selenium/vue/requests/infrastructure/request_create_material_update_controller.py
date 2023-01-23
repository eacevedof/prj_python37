from vue.requests.application.request_create_service import request_create_material_update


def __request_create_material_update() -> None:
    try:
        request_create_material_update()
    except Exception as e:
        print(e)


__request_create_material_update()
