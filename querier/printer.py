def pr_red(text):
    """Prints text in red."""
    print(f"\033[91m{text}\033[0m")

def pr_green(text):
    """Prints text in green."""
    print(f"\033[92m{text}\033[0m")

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