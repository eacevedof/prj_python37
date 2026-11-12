"""p.41 — la ruta del fichero nunca debe llegar a PowerShell como código."""

import sys
from pathlib import Path

import pytest

from src.modules.filechecker_mod.domain.enums import FileCheckerResponseKeyEnum
from src.modules.filechecker_mod.infrastructure.repositories.file_signature_reader_file_repository import (
    FileSignatureReaderFileRepository,
)

_MALICIOUS_NAME = "x';Set-Content -LiteralPath $env:FILECHECKER_PWNED_MARKER -Value pwned;'.exe"


def test_the_path_travels_only_in_the_environment() -> None:
    file_path = rf"C:\Windows\{_MALICIOUS_NAME}"

    cmd, env = FileSignatureReaderFileRepository.get_authenticode_command(file_path)

    assert all(file_path not in part and _MALICIOUS_NAME not in part for part in cmd)
    assert "-LiteralPath" in cmd[-1]
    assert env["FILECHECKER_SIGNATURE_PATH"] == file_path


@pytest.mark.skipif(sys.platform != "win32", reason="Authenticode solo existe en Windows")
def test_a_malicious_file_name_is_not_executed(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    marker = tmp_path / "pwned.txt"
    monkeypatch.setenv("FILECHECKER_PWNED_MARKER", str(marker))
    malicious_file = tmp_path / _MALICIOUS_NAME
    malicious_file.write_bytes(b"MZ not really an exe")

    result = FileSignatureReaderFileRepository.get_instance().get_signature_info(str(malicious_file))

    assert not marker.exists()
    assert result[FileCheckerResponseKeyEnum.SIGNATURE_METHOD] == "authenticode"
    assert result[FileCheckerResponseKeyEnum.SIGNATURE_STATUS] in {"unsigned", "unknown"}


@pytest.mark.skipif(sys.platform != "win32", reason="Authenticode solo existe en Windows")
def test_a_signed_windows_binary_is_valid() -> None:
    result = FileSignatureReaderFileRepository.get_instance().get_signature_info(
        r"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    )

    assert result[FileCheckerResponseKeyEnum.SIGNATURE_STATUS] == "valid"
    assert "Microsoft" in (result[FileCheckerResponseKeyEnum.SIGNATURE_SIGNER] or "")
