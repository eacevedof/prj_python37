import os
import subprocess
import sys
from typing import Self, final

from ddd.file_checker.domain.enums import FileCheckerResponseKeyEnum


@final
class FileSignatureReaderFileRepository:
    """Reader repository for file digital signature verification."""

    _instance: "FileSignatureReaderFileRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self) -> None:
        pass

    def get_signature_info(self, file_path: str) -> dict:
        """Verify file digital signature (platform-specific).

        Args:
            file_path: Path to the file on disk.

        Returns:
            Dict with SIGNATURE_STATUS, SIGNATURE_METHOD, SIGNATURE_SIGNER.
            All fields may be None if platform does not support or verification fails.
        """
        if sys.platform == "win32":
            return self._verify_authenticode(file_path)
        elif sys.platform == "linux":
            return self._verify_gpg(file_path)
        elif sys.platform == "darwin":
            return self._verify_codesign(file_path)
        else:
            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: None,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: None,
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: None,
            }

    @staticmethod
    def _verify_authenticode(file_path: str) -> dict:
        """Verify Windows Authenticode signature via PowerShell."""
        try:
            cmd = [
                "powershell",
                "-Command",
                f"Get-AuthenticodeSignature -FilePath '{file_path}' | Select-Object -Property Status,SignerCertificate",
            ]
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)

            status = "unsigned"
            signer = None

            if result.returncode == 0:
                output = result.stdout.lower()
                if "validsignature" in output or "valid" in output:
                    status = "valid"
                elif "unknownerror" in output or "error" in output:
                    status = "unknown"
                elif "badsignature" in output:
                    status = "bad_signature"

                if "cn=" in output:
                    for line in result.stdout.split("\n"):
                        if "CN=" in line or "Subject=" in line:
                            signer = line.strip()
                            break

            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: status,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: "authenticode",
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: signer,
            }
        except (subprocess.TimeoutExpired, FileNotFoundError, Exception):
            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: None,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: None,
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: None,
            }

    @staticmethod
    def _verify_gpg(file_path: str) -> dict:
        """Verify Linux GPG signature (.asc sidecar)."""
        asc_path = f"{file_path}.asc"

        if not os.path.exists(asc_path):
            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: None,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: None,
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: None,
            }

        try:
            cmd = ["gpg", "--verify", asc_path, file_path]
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)

            status = "bad_signature"
            signer = None

            if result.returncode == 0:
                status = "valid"

            for line in result.stderr.split("\n"):
                if "Good signature" in line or "gpg:" in line:
                    signer = line.strip()
                    break

            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: status,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: "gpg",
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: signer,
            }
        except (subprocess.TimeoutExpired, FileNotFoundError, Exception):
            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: None,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: None,
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: None,
            }

    @staticmethod
    def _verify_codesign(file_path: str) -> dict:
        """Verify macOS code signature via codesign."""
        try:
            cmd = ["codesign", "--verify", "--verbose=4", file_path]
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)

            status = "unsigned"
            signer = None

            if result.returncode == 0:
                status = "valid"
            elif "not signed" in result.stderr.lower():
                status = "unsigned"
            else:
                status = "bad_signature"

            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: status,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: "codesign",
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: signer,
            }
        except (subprocess.TimeoutExpired, FileNotFoundError, Exception):
            return {
                FileCheckerResponseKeyEnum.SIGNATURE_STATUS: None,
                FileCheckerResponseKeyEnum.SIGNATURE_METHOD: None,
                FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: None,
            }
