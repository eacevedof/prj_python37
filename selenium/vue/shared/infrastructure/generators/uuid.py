import random
import string


def get_uuid(size=32, chars=string.ascii_letters + string.digits) -> str:
    return "".join(random.choice(chars) for _ in range(size))
