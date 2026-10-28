from enum import StrEnum
from typing import final


@final
class FileExecutableFormatEnum(StrEnum):
    """Executable file formats across operating systems.

    Each format describes how the OS structures executable files, including
    headers, sections, and metadata (version, description, product name, etc.).
    """

    PE = "pe"
    ELF = "elf"
    MACHO = "macho"

    @staticmethod
    def get_info(format_type: "FileExecutableFormatEnum") -> str:
        """Get detailed information about an executable format.

        Args:
            format_type: PE, ELF, or Mach-O format identifier.

        Returns:
            str: Description of the format and its use.
        """
        info = {
            FileExecutableFormatEnum.PE: (
                "PE (Portable Executable) — Windows executable format\n"
                "  • Used by: Windows .exe, .dll, .sys files\n"
                "  • Contains: DOS header, PE header, sections (code, data, resources)\n"
                "  • Metadata: version, description, product_name, company, file_version\n"
                "  • Signature verification: Authenticode (cryptographic signature by publisher)\n"
                "  • Tools: pywin32, certifi, Get-AuthenticodeSignature (PowerShell)"
            ),
            FileExecutableFormatEnum.ELF: (
                "ELF (Executable and Linkable Format) — Linux/Unix executable format\n"
                "  • Used by: Linux .elf, .so (shared libraries), most Unix executables\n"
                "  • Contains: ELF header, program headers, sections (.text, .data, .symtab)\n"
                "  • Metadata: version (via .gnu.version section), no built-in description\n"
                "  • Signature verification: GPG signatures (if .asc file exists alongside binary)\n"
                "  • Tools: pyelftools, gpg (command-line), readelf (standard Linux tool)"
            ),
            FileExecutableFormatEnum.MACHO: (
                "Mach-O (Mach Object) — macOS executable format\n"
                "  • Used by: macOS binaries, .app bundles, .dylib (dynamic libraries)\n"
                "  • Contains: Mach-O header, load commands, segments (__TEXT, __DATA, __LINKEDIT)\n"
                "  • Metadata: version (via LC_VERSION_MIN load command), no built-in description\n"
                "  • Signature verification: Code Signing (Apple's code signature + entitlements)\n"
                "  • Tools: pymacho, codesign (macOS native), otool (standard macOS tool)"
            ),
        }
        return info.get(format_type, f"Unknown format: {format_type.value if format_type else "None"}")
