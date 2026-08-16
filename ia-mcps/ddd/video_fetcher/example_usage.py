"""Example usage of video_fetcher module."""

import asyncio
from ddd.video_fetcher.application import (
    DownloadVideoService
)


async def ideo_type_detection():
    """Test video type detection."""
    print("\n=== Testing Video Type Detection ===")
    
    service = DownloadVideoService.get_instance()
    
    test_cases = [
        #("https://example.com/video.mp4", "DIRECT_MP4"),
        #("https://example.com/stream.m3u8", "M3U8_HLS"),
        ("blob:https://www.linkedin.com/b12a7fdc-5b6c-4483-9997-2d274772b216", "BLOB_FRAGMENTED"),
        #("https://example.com/video.mov", "DIRECT_MP4"),
    ]
    
    for url, expected_type in test_cases:
        detected_type = service._detect_video_type(url)
        status = "✓" if expected_type in detected_type else "✗"
        print(f"{status} {url} -> {detected_type}")



async def main():
    """Run all tests."""
    await ideo_type_detection()



if __name__ == "__main__":
    asyncio.run(main())
