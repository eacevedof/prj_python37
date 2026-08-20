from typing import final


@final
class FileCheckerHashConstantsEnum:
    """Hash computation constants used across the FileChecker module."""

    CHUNK_SIZE = 65536  # 64 KB — balances memory usage and I/O calls for large files
