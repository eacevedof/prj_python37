"""Enum for video source types."""

from enum import StrEnum


class VideoTypeEnum(StrEnum):
    """Video source types."""

    DIRECT_MP4 = "direct_mp4"
    BLOB_FRAGMENTED = "blob_fragmented"
    M3U8_HLS = "m3u8_hls"
    UNKNOWN = "unknown"

    def __iter__(self):
        return iter([self.DIRECT_MP4, self.BLOB_FRAGMENTED, self.M3U8_HLS, self.UNKNOWN])
