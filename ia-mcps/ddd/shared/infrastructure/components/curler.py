from typing import final, Self, Any

import aiohttp


@final
class Curler:
    """Async HTTP client wrapper for making API requests."""

    _DEFAULT_TIMEOUT: int = 120

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_response(self, url: str, timeout: int | None = None) -> dict[str, Any]:
        request_timeout = timeout or self._DEFAULT_TIMEOUT
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(url, timeout=aiohttp.ClientTimeout(total=request_timeout)) as response:
                    response_text = await response.text()
                    return {
                        "url": url,
                        "status_code": response.status,
                        "error": "",
                        "response": response_text,
                    }
        except aiohttp.ClientError as e:
            return {
                "url": url,
                "status_code": 0,
                "error": str(e),
                "response": "",
            }

    async def get_response_with_headers(
        self,
        url: str,
        headers: dict[str, str],
        timeout: int = 30
    ) -> dict[str, Any]:
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(
                    url,
                    headers=headers,
                    timeout=aiohttp.ClientTimeout(total=timeout)
                ) as response:
                    response_text = await response.text()
                    return {
                        "url": url,
                        "status_code": response.status,
                        "error": "",
                        "response": response_text,
                    }
        except aiohttp.ClientError as e:
            return {
                "url": url,
                "status_code": 0,
                "error": str(e),
                "response": "",
            }

    async def post_response(
        self,
        url: str,
        payload: dict[str, Any],
        headers: dict[str, str] | None = None,
        timeout: int = 30
    ) -> dict[str, Any]:
        request_headers = headers or {"Content-Type": "application/json"}
        try:
            async with aiohttp.ClientSession() as session:
                async with session.post(
                    url,
                    json=payload,
                    headers=request_headers,
                    timeout=aiohttp.ClientTimeout(total=timeout)
                ) as response:
                    response_text = await response.text()
                    return {
                        "url": url,
                        "status_code": response.status,
                        "error": "",
                        "response": response_text,
                    }
        except aiohttp.ClientError as e:
            return {
                "url": url,
                "status_code": 0,
                "error": str(e),
                "response": "",
            }

    async def get_status(self, url: str, timeout: int = 30) -> dict[str, Any]:
        try:
            async with aiohttp.ClientSession() as session:
                async with session.head(
                    url,
                    timeout=aiohttp.ClientTimeout(total=timeout)
                ) as response:
                    return {
                        "url": url,
                        "status_code": response.status,
                        "error": "",
                        "response": "",
                    }
        except aiohttp.ClientError as e:
            return {
                "url": url,
                "status_code": 0,
                "error": str(e),
                "response": "",
            }
