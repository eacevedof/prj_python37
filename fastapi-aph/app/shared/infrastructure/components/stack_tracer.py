import traceback
import inspect
from typing import List


class StackTracer:
    @staticmethod
    def get_current_method() -> str:
        frame = inspect.currentframe()
        if frame and frame.f_back and frame.f_back.f_back:
            return frame.f_back.f_back.f_code.co_name
        return "unknown"
    
    @staticmethod
    def get_current_method_with_class() -> str:
        frame = inspect.currentframe()
        if frame and frame.f_back and frame.f_back.f_back:
            code = frame.f_back.f_back.f_code
            if 'self' in frame.f_back.f_back.f_locals:
                class_name = frame.f_back.f_back.f_locals['self'].__class__.__name__
                return f"{class_name}.{code.co_name}"
            return code.co_name
        return "unknown"
    
    @staticmethod
    def get_full_stack_trace() -> List[str]:
        return traceback.format_stack()[:-1]