from vue.login.application.login_service import login_usr1_or_fail


def login_usr1() -> None:
    try:
        login_usr1_or_fail()
    except Exception as e:
        print(e)


login_usr1()
