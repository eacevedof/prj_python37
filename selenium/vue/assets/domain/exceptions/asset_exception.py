class LoginException:
    def __int__(self):
        pass

    def fail_if_no_input(self, message: str = "") -> None:
        raise Exception(message)

    def fail_if_no_button(self, message: str = "") -> None:
        raise Exception(message)

    def fail_if_not_logged(self, message: str = "") -> None:
        raise Exception(message)
