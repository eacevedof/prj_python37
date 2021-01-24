from src.boot.paths import PATH_LOGS
from src.components.log_component import LogComponent

def get_log(subtype: str="debug") -> LogComponent:
    return LogComponent(pathfolder=PATH_LOGS, subtype=subtype)
