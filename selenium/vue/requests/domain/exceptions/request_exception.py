class RequestException:
    def __int__(self):
        pass

    def fail_if_no_input(self, message: str = "") -> None:
        raise Exception(message)