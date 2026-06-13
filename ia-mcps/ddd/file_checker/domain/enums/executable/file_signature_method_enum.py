from enum import StrEnum
from typing import final


@final
class FileSignatureMethodEnum(StrEnum):
    """Signature verification methods by platform.

    Each platform has native mechanisms to verify that a binary was signed
    by a trusted authority (proving authenticity and non-tampering).
    """

    AUTHENTICODE = "authenticode"  # Windows
    GPG = "gpg"                    # Linux
    CODESIGN = "codesign"          # macOS

    @staticmethod
    def get_info(method: "FileSignatureMethodEnum") -> str:
        """Get detailed information about a signature verification method.

        Args:
            method: AUTHENTICODE, GPG, or CODESIGN.

        Returns:
            str: Description of the method and how it works.
        """
        info: dict[FileSignatureMethodEnum, str] = {
            FileSignatureMethodEnum.AUTHENTICODE: (
                "Authenticode — Windows code signing standard\n"
                "  • Cryptographic signature embedded in PE executable headers\n"
                "  • Proves: Binary was signed by publisher's private key (authenticity)\n"
                "  • Validates: Certificate chain → trusted root CA in Windows cert store\n"
                "  • Status codes:\n"
                "    - Valid: Signature OK, certificate trusted\n"
                "    - Unsigned: No signature embedded (common for open-source)\n"
                "    - BadSignature: Signature does not match file contents (tampering)\n"
                "    - UnknownError: Verification failed (cert revoked, untrusted CA, etc.)\n"
                "  • Tools: PowerShell Get-AuthenticodeSignature, WinTrustVerify API"
            ),
            FileSignatureMethodEnum.GPG: (
                "GPG (GNU Privacy Guard) — Linux/Unix code signing standard\n"
                "  • Detached signature in separate .asc file (sidecar to binary)\n"
                "  • Proves: Binary was signed by author's GPG private key (authenticity)\n"
                "  • Validates: Signature against author's public key in GPG keyring\n"
                "  • Usage: Developers publish binary + .asc signature; users verify locally\n"
                "  • Status codes:\n"
                "    - Good: Signature OK, signer's key found (may warn 'untrusted')\n"
                "    - BadSignature: Signature does not match file (tampering)\n"
                "    - NoSignature: No .asc file found (common for packages in repos)\n"
                "    - NoKey: Signer's public key not in local keyring\n"
                "  • Tools: gpg (command-line), python-gnupg (Python)"
            ),
            FileSignatureMethodEnum.CODESIGN: (
                "Code Signing — macOS/iOS code signing standard\n"
                "  • Cryptographic signature embedded in Mach-O executable or .app bundle\n"
                "  • Proves: Binary was signed by Apple developer (authenticity)\n"
                "  • Validates: Signature + entitlements + certificate chain\n"
                "  • Gatekeeper: macOS kernel checks signature on app launch\n"
                "  • Status codes:\n"
                "    - Valid: Signature OK, developer trusted by macOS\n"
                "    - Unsigned: No signature (unnotarized, rejected by Gatekeeper)\n"
                "    - InvalidSignature: Signature tampered or cert revoked\n"
                "  • Tools: codesign (command-line), spctl (validation), xattr (entitlements)"
            ),
        }
        return info.get(method, f"Unknown method: {method.value if method else 'None'}")
