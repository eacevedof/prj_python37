from vue.oco.tactical_requests.application.tactical_requests_create_new_dev_service import invoke


def __invoke() -> None:
    try:
        invoke()
    except Exception as e:
        print(e)


__invoke()
