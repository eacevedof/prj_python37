from typing import final, Self


@final
class Printer:
    _RESET: str = "\033[0m"
    _RED: str = "\033[91m"
    _GREEN: str = "\033[92m"
    _LEMON: str = "\033[92;1m"
    _YELLOW: str = "\033[93m"
    _BLUE: str = "\033[94m"
    _WHITE: str = "\033[97m"
    _ORANGE: str = "\033[38;5;214m"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def print_red(self, text: str) -> None:
        print(f"{self._RED}{text}{self._RESET}")

    def print_green(self, text: str) -> None:
        print(f"{self._GREEN}{text}{self._RESET}")

    def print_lemon(self, text: str) -> None:
        print(f"{self._LEMON}{text}{self._RESET}")

    def print_yellow(self, text: str) -> None:
        print(f"{self._YELLOW}{text}{self._RESET}")

    def print_blue(self, text: str) -> None:
        print(f"{self._BLUE}{text}{self._RESET}")

    def print_white(self, text: str) -> None:
        print(f"{self._WHITE}{text}{self._RESET}")

    def print_orange(self, text: str) -> None:
        print(f"{self._ORANGE}{text}{self._RESET}")

    def get_red(self, text: str) -> str:
        return f"{self._RED}{text}{self._RESET}"

    def get_green(self, text: str) -> str:
        return f"{self._GREEN}{text}{self._RESET}"

    def get_yellow(self, text: str) -> str:
        return f"{self._YELLOW}{text}{self._RESET}"

    def die(self, text: str) -> None:
        self.print_red(text)
        exit(1)


# Mantener compatibilidad con imports existentes
_printer = Printer.get_instance()
pr_red = _printer.print_red
pr_green = _printer.print_green
pr_lemon = _printer.print_lemon
pr_yellow = _printer.print_yellow
pr_blue = _printer.print_blue
pr_white = _printer.print_white
pr_orange = _printer.print_orange
get_red = _printer.get_red
get_green = _printer.get_green
get_yellow = _printer.get_yellow
die = _printer.die