from typing import final


@final
class MysqlDockerConst:
    """Docker container and credentials for the local MySQL server."""

    CONTAINER_NAME = "cont-lr-mysql"
    ROOT_USER = "root"
    ROOT_PASSWORD = "root"
    USER_FLAG = "-uroot"
    PASSWORD_FLAG = "-proot"
