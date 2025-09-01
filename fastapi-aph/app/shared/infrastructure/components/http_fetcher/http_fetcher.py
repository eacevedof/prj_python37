import asyncio
import aiohttp
import json
from typing import Any, Dict, Optional, Union
from dataclasses import dataclass
from urllib.parse import urlencode


@dataclass
class HttpFetcherResponseType:
    url: str
    status_code: int
    error: Optional[str]
    response: Optional[str]


@dataclass
class HttpFetcherFullOptionType:
    method: Optional[str] = None
    headers: Optional[Dict[str, str]] = None
    body: Optional[Dict[str, Any]] = None
    timeout: Optional[int] = None
    is_url_encoded: Optional[bool] = None


class HttpFetcher:
    def __init__(self):
        self.one_hundred_twenty_seconds = 120  # 120 seconds like PHP version
        self.thirty_seconds = 30  # 30 seconds like PHP version
    
    @staticmethod
    def get_instance():
        return HttpFetcher()
    
    async def http_get(
        self, 
        request_url: str, 
        request_headers: Optional[Dict[str, str]] = None
    ) -> HttpFetcherResponseType:
        return await self.custom_http_request(request_url, HttpFetcherFullOptionType(
            method="GET",
            headers=request_headers,
            timeout=self.one_hundred_twenty_seconds
        ))
    
    async def http_post(
        self,
        request_url: str,
        request_body: Dict[str, Any],
        request_headers: Optional[Dict[str, str]] = None
    ) -> HttpFetcherResponseType:
        headers = {
            "Content-Type": "application/json",
            **(request_headers or {})
        }
        
        full_custom_options = HttpFetcherFullOptionType(
            method="POST",
            headers=headers,
            body=request_body,
            is_url_encoded=False,
            timeout=self.one_hundred_twenty_seconds
        )
        
        return await self.custom_http_request(request_url, full_custom_options)
    
    async def http_post_by_url_search_params(
        self,
        request_url: str,
        request_body: Dict[str, Any],
        request_headers: Optional[Dict[str, str]] = None
    ) -> HttpFetcherResponseType:
        headers = {
            "Content-Type": "application/x-www-form-urlencoded",
            **(request_headers or {})
        }
        
        full_custom_options = HttpFetcherFullOptionType(
            method="POST",
            headers=headers,
            body=request_body,
            is_url_encoded=True,
            timeout=self.one_hundred_twenty_seconds
        )
        
        return await self.custom_http_request(request_url, full_custom_options)
    
    async def http_get_with_headers(
        self,
        request_url: str,
        request_headers: Dict[str, str]
    ) -> HttpFetcherResponseType:
        return await self.custom_http_request(request_url, HttpFetcherFullOptionType(
            method="GET",
            headers=request_headers,
            timeout=self.thirty_seconds
        ))
    
    async def http_get_with_body(
        self,
        request_url: str,
        request_body: Dict[str, Any],
        request_headers: Optional[Dict[str, str]] = None
    ) -> HttpFetcherResponseType:
        headers = {
            "Content-Type": "application/json",
            **(request_headers or {})
        }
        
        return await self.custom_http_request(request_url, HttpFetcherFullOptionType(
            method="GET",
            headers=headers,
            body=request_body,
            timeout=self.one_hundred_twenty_seconds
        ))
    
    async def http_get_status(
        self,
        request_url: str,
        request_headers: Optional[Dict[str, str]] = None
    ) -> HttpFetcherResponseType:
        return await self.custom_http_request(request_url, HttpFetcherFullOptionType(
            method="HEAD",
            headers=request_headers,
            timeout=30
        ))
    
    async def http_any_by_custom_options(
        self,
        request_url: str,
        request_custom_options: HttpFetcherFullOptionType
    ) -> HttpFetcherResponseType:
        options = HttpFetcherFullOptionType(
            timeout=self.one_hundred_twenty_seconds,
            method=request_custom_options.method,
            headers=request_custom_options.headers,
            body=request_custom_options.body,
            is_url_encoded=request_custom_options.is_url_encoded
        )
        return await self.custom_http_request(request_url, options)
    
    async def custom_http_request(
        self,
        request_url: str,
        http_fetcher_full_options: HttpFetcherFullOptionType
    ) -> HttpFetcherResponseType:
        timeout = aiohttp.ClientTimeout(
            total=http_fetcher_full_options.timeout or self.one_hundred_twenty_seconds
        )
        
        try:
            async with aiohttp.ClientSession(timeout=timeout) as session:
                data = None
                
                if http_fetcher_full_options.body:
                    if http_fetcher_full_options.is_url_encoded:
                        data = urlencode(http_fetcher_full_options.body)
                    else:
                        data = json.dumps(http_fetcher_full_options.body)
                
                async with session.request(
                    method=http_fetcher_full_options.method or "GET",
                    url=request_url,
                    headers=http_fetcher_full_options.headers,
                    data=data
                ) as response:
                    response_text = await response.text()
                    return HttpFetcherResponseType(
                        url=request_url,
                        status_code=response.status,
                        error=None,
                        response=response_text
                    )
        
        except asyncio.TimeoutError:
            return HttpFetcherResponseType(
                url=request_url,
                status_code=408,
                error="Request timeout",
                response=None
            )
        except Exception as error:
            return HttpFetcherResponseType(
                url=request_url,
                status_code=520,
                error=str(error),
                response=None
            )