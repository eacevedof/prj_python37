import random
from typing import final


@final
class Randomizer:
    @staticmethod
    def get_instance():
        return Randomizer()
    
    def get_random_number_between_min_and_max(self, min_val: int = 0, max_val: int = 100) -> int:
        return random.randint(min_val, max_val)