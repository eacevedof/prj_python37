"""DTO for downloading video files."""

import os
from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class DownloadVideoDto:
    """DTO for parameterizing video download."""

    url: str
    output_dir: str | None = None
    filename: str | None = None
    headers: dict[str, str] | None = None

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        url = str(primitives.get("url", "")).strip()
        output_dir = primitives.get("output_dir")
        if output_dir:
            output_dir = str(output_dir).strip()
        filename = primitives.get("filename")
        if filename:
            filename = str(filename).strip()
        headers = primitives.get("headers")
        if headers and isinstance(headers, dict):
            headers = {str(k): str(v) for k, v in headers.items()}

        return cls(
            url=url,
            output_dir=output_dir,
            filename=filename,
            headers=headers,
        )

    def __post_init__(self) -> None:
        if not self.url or not self.url.strip():
            raise ValueError("DownloadVideoDto: url cannot be empty")
