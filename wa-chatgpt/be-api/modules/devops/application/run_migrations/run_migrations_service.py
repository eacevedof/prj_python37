from dataclasses import dataclass
from typing import final


@final
@dataclass
class RunMigrationsService:
    page: ft.Page
    __text_username: TextField = field(init=False)
    __text_password: TextField = field(init=False)
    __chk_agree: Checkbox = field(init=False)
    __btn_signup: ElevatedButton = field(init=False)

    def __post_init__(self):
        self.page.title = "Signup"


    def __configure_input_events(self) -> None:
