import json
from typing import Any

def dump(var: Any)->str:
  try:
    return json.dumps(
      var,
      default=lambda o: o.__dict__ if hasattr(o, '__dict__') else str(o),
      sort_keys=True,
      indent=4
    )
  except TypeError as e:
    return str(var)