"""Example usage of video_fetcher module."""

import asyncio
from ddd.video_fetcher.application import (
    DownloadVideoDto,
    DownloadVideoService
)
from ddd.video_fetcher.domain.exceptions import VideoFetcherException


async def download_direct_video():
    """Example: Download direct mp4 video."""
    print("\n=== Downloading direct MP4 ===")
    try:
        dto = DownloadVideoDto.from_primitives({
            "url": "https://example.com/sample-video.mp4",
            "output_dir": "C:\projects\tmp",
            "filename": "direct-video.mp4"
        })
        
        result = await DownloadVideoService.get_instance()(dto)
        
        print(f"✓ Downloaded: {result.file_path}")
        print(f"  Size: {result.file_size_bytes} bytes")
        print(f"  Type: {result.video_type}")
        print(f"  Status: {result.download_status}")
        
    except VideoFetcherException as e:
        print(f"✗ Error: {e.message} (code: {e.code})")


async def download_m3u8_video():
    """Example: Download m3u8/HLS video."""
    print("\n=== Downloading M3U8/HLS video ===")
    try:
        dto = DownloadVideoDto.from_primitives({
            "url": "https://example.com/stream.m3u8",
            "output_dir": "C:\projects\tmp"
        })
        
        result = await DownloadVideoService.get_instance()(dto)
        
        print(f"✓ Downloaded: {result.file_path}")
        print(f"  Size: {result.file_size_bytes} bytes")
        print(f"  Type: {result.video_type}")
        print(f"  Fragments: {result.fragments_count}")
        print(f"  Status: {result.download_status}")
        
    except VideoFetcherException as e:
        print(f"✗ Error: {e.message} (code: {e.code})")


async def download_with_headers():
    """Example: Download video with custom headers."""
    print("\n=== Downloading with custom headers ===")
    try:
        dto = DownloadVideoDto.from_primitives({
            "url": "https://example.com/protected-video.mp4",
            "output_dir": "C:\projects\tmp",
            "headers": {
                "User-Agent": "Mozilla/5.0",
                "Referer": "https://example.com"
            }
        })
        
        result = await DownloadVideoService.get_instance()(dto)
        
        print(f"✓ Downloaded: {result.file_path}")
        
    except VideoFetcherException as e:
        print(f"✗ Error: {e.message} (code: {e.code})")


async def main():
    """Run all examples."""
    print("=" * 60)
    print("Video Fetcher - Usage Examples")
    print("=" * 60)
    
    await download_direct_video()
    await download_m3u8_video()
    await download_with_headers()
    
    print("\n" + "=" * 60)
    print("Examples completed")
    print("=" * 60)


if __name__ == "__main__":
    asyncio.run(main())
