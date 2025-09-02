class DomainException(Exception):
    """Base domain exception"""
    
    def __init__(self, exception_type: str, status_code: int, message: str) -> None:
        self.exception_type = exception_type
        self.status_code = status_code
        self.message = message
        super().__init__(self.message)
    
    def get_status_code(self) -> int:
        return self.status_code
    
    def get_message(self) -> str:
        return self.message
    
    def get_exception_type(self) -> str:
        return self.exception_type