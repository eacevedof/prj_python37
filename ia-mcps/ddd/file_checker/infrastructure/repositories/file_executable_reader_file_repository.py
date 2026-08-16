from typing import Self, final

from ddd.file_checker.domain.enums import FileCheckerResponseKeyEnum


@final
class FileExecutableReaderFileRepository:
    """Reader repository for executable file format detection and metadata."""

    _instance: "FileExecutableReaderFileRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self) -> None:
        pass

    def get_executable_info(self, file_path: str) -> dict:
        """Detect executable format (PE/ELF/Mach-O) and extract metadata.

        Args:
            file_path: Path to the file on disk.

        Returns:
            Dict with EXECUTABLE_FORMAT and optional version/description/product_name/company.
            All fields may be None if file is not an executable or metadata is unavailable.
        """
        with open(file_path, "rb") as f:
            magic_bytes = f.read(4)

        executable_format = self._detect_format(magic_bytes)

        if not executable_format:
            return {
                FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: None,
                FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: None,
                FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: None,
                FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: None,
                FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: None,
            }

        if executable_format == "pe":
            return self._get_pe_info(file_path, magic_bytes)
        elif executable_format == "elf":
            return self._get_elf_info()
        elif executable_format == "macho":
            return self._get_macho_info()

        return {
            FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: None,
        }

    @staticmethod
    def _detect_format(magic_bytes: bytes) -> str | None:
        """Detect executable format from magic bytes."""
        if len(magic_bytes) >= 2 and magic_bytes[:2] == b"MZ":
            return "pe"
        if len(magic_bytes) >= 4 and magic_bytes[:4] == b"\x7fELF":
            return "elf"
        if len(magic_bytes) >= 4:
            if magic_bytes[:4] in (b"\xce\xfa\xed\xfe", b"\xcf\xfa\xed\xfe", b"\xfe\xed\xfa\xce", b"\xca\xfe\xba\xbe"):
                return "macho"
        return None

    def _get_pe_info(self, file_path: str, magic_bytes: bytes) -> dict:
        """Extract PE (Windows) executable metadata."""
        version = None
        description = None
        product_name = None
        company = None

        try:
            import pefile

            pe = pefile.PE(file_path)
            if hasattr(pe, "VS_FIXEDFILEINFO") and pe.VS_FIXEDFILEINFO:
                version = f"{pe.VS_FIXEDFILEINFO[0].ProductVersionMS >> 16}.{pe.VS_FIXEDFILEINFO[0].ProductVersionMS & 0xFFFF}"

            if hasattr(pe, "FileInfo") and pe.FileInfo:
                for fileinfo in pe.FileInfo:
                    if hasattr(fileinfo, "StringInfos"):
                        for stringinfo in fileinfo.StringInfos:
                            if hasattr(stringinfo, "entries"):
                                entries = stringinfo.entries
                                description = entries.get("FileDescription", description)
                                product_name = entries.get("ProductName", product_name)
                                company = entries.get("CompanyName", company)
        except (ImportError, Exception):
            pass

        return {
            FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: "pe",
            FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: version,
            FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: description,
            FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: product_name,
            FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: company,
        }

    @staticmethod
    def _get_elf_info() -> dict:
        """Extract ELF (Linux) executable metadata."""
        return {
            FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: "elf",
            FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: None,
        }

    @staticmethod
    def _get_macho_info() -> dict:
        """Extract Mach-O (macOS) executable metadata."""
        return {
            FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: "macho",
            FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: None,
            FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: None,
        }
