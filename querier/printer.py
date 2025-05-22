def pr_red(text):
    """Prints text in red."""
    print(f"\033[91m{text}\033[0m")

def get_red(text):
    """Returns text in red."""
    return f"\033[91m{text}\033[0m"

def pr_green(text):
    """Prints text in green."""
    print(f"\033[92m{text}\033[0m")

def pr_lemon(text):
    """Prints text in lemon color."""
    print(f"\033[92;1m{text}\033[0m")

def get_green(text):
    """Returns text in green."""
    return f"\033[92m{text}\033[0m"

def pr_yellow(text):
    """Prints text in yellow."""
    print(f"\033[93m{text}\033[0m")

def pr_blue(text):
    """Prints text in blue."""
    print(f"\033[94m{text}\033[0m")

def get_yellow(text):
    """Returns text in yellow."""
    return f"\033[93m{text}\033[0m"

def pr_white(text):
    """Prints text in white."""
    print(f"\033[97m{text}\033[0m")

def pr_orange(text):
    """Prints text in orange."""
    print(f"\033[38;5;214m{text}\033[0m")

def die(text):
    """Prints text in red and exits the program."""
    pr_red(text)
    exit(1)