import json
from typing import Any, Dict


def get_attributes(obj: Any) -> Dict[str, Any]:
  return {attr: getattr(obj, attr) for attr in dir(obj) if
          not attr.startswith('__') and not callable(getattr(obj, attr))}


def dump(var: Any) -> str:
    if isinstance(var, str):
        return var

    if isinstance(var, (int, float)):
        return str(var)

    if isinstance(var, dict):
        return json.dumps(var, indent=4)

    if isinstance(var, list):
        return json.dumps(var, indent=4)

    if isinstance(var, tuple):
        return json.dumps(var, indent=4)

    some_dic = get_attributes(var)
    return json.dumps(some_dic, indent=4)
