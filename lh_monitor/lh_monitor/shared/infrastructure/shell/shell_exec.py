import subprocess


class ShellExecException(Exception):
    @staticmethod
    def fail_if_empty_commands():
        raise ShellExecException("No commands to execute")


class ShellExec:
    def __init__(self):
        self.commands = []
        self.one_line_command = ""
        self.output = []
        self.result_code = 0  # ok

    @classmethod
    def get_instance(cls):
        return cls()

    def add_command(self, command):
        self.commands.append(command)
        return self

    def exec(self):
        self._load_one_line_command()
        if not self.one_line_command:
            ShellExecException.fail_if_empty_commands()

        try:
            process = subprocess.run(
                self.one_line_command,
                shell=True,
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True
            )
            self.output = process.stdout.splitlines()
        except subprocess.CalledProcessError as ex:
            self.result_code = 1
            self.output = ex.stderr.splitlines()
        return self

    def _load_one_line_command(self):
        if self.one_line_command:
            return

        one_line_command = " ".join(self.commands)
        self.one_line_command = one_line_command.strip()

    def get_output(self):
        return self.output

    def is_error(self):
        return bool(self.result_code)

    def print_debug_command(self):
        self._load_one_line_command()
        print(self.one_line_command)

    def get_command(self):
        self._load_one_line_command()
        return self.one_line_command

    def reset(self):
        self.commands = []
        self.one_line_command = ""
        self.output = []
        self.result_code = 0
        return self
