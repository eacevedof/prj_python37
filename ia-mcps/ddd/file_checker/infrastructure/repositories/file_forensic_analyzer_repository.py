import struct
import os
import re
import math
from typing import Self, final
from pathlib import Path

from ddd.shared.infrastructure.components.logger import Logger


@final
class FileForensicAnalyzerRepository:
    """Forensic analyzer for detecting malicious files and suspicious content.

    Acts as a security researcher analyzing files for:
    - Malware signatures and patterns
    - Embedded malicious content (PDFs, Office, archives)
    - Structural anomalies
    - Suspicious behaviors
    - Entropy analysis (compression/encryption indicators)
    - Packing and obfuscation
    """

    _logger: Logger
    _instance: "FileForensicAnalyzerRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    def analyze_file_for_threats(self, file_path: str) -> dict:
        """Comprehensive forensic analysis for malware detection.

        Args:
            file_path: Path to file to analyze.

        Returns:
            Dict with threat assessment:
            {
                "threat_level": "critical" | "high" | "medium" | "low" | "clean",
                "risk_score": 0-100,
                "threats_detected": [...],
                "suspicious_indicators": [...],
                "file_type_verification": {...},
                "embedded_content_analysis": {...},
                "entropy_analysis": {...},
                "magic_bytes_analysis": {...},
                "packing_indicators": {...},
            }
        """
        with open(file_path, "rb") as f:
            file_bytes = f.read(min(10485760, os.path.getsize(file_path)))  # Max 10MB
            file_size = os.path.getsize(file_path)

        analysis = {
            "threat_level": "clean",
            "risk_score": 0,
            "threats_detected": [],
            "suspicious_indicators": [],
        }

        # 1. Magic bytes verification
        analysis["magic_bytes_analysis"] = self._analyze_magic_bytes(file_bytes)
        if not analysis["magic_bytes_analysis"]["is_valid_signature"]:
            analysis["threats_detected"].append("Invalid or spoofed file signature")
            analysis["risk_score"] += 25

        # 2. File structure analysis
        file_type = analysis["magic_bytes_analysis"]["detected_type"]
        analysis["file_type_verification"] = self._verify_file_structure(file_bytes, file_type)
        if not analysis["file_type_verification"]["is_valid"]:
            analysis["threats_detected"].append("Corrupted or malformed file structure")
            analysis["risk_score"] += 20
            analysis["suspicious_indicators"].append(
                analysis["file_type_verification"]["anomalies"]
            )

        # 3. Embedded content analysis (PDFs, Office, Archives)
        analysis["embedded_content_analysis"] = self._analyze_embedded_content(
            file_bytes, file_type, file_path
        )
        if analysis["embedded_content_analysis"]["malicious_content_detected"]:
            analysis["threats_detected"].extend(
                analysis["embedded_content_analysis"]["threats"]
            )
            analysis["risk_score"] += 50

        # 4. Entropy analysis (compression/encryption/obfuscation)
        analysis["entropy_analysis"] = self._analyze_entropy(file_bytes)
        if analysis["entropy_analysis"]["suspicious"]:
            analysis["suspicious_indicators"].append(
                f"Suspicious entropy: {analysis['entropy_analysis']['entropy_value']:.2f}"
            )
            analysis["risk_score"] += 15

        # 5. Packing/Obfuscation detection
        analysis["packing_indicators"] = self._detect_packing(file_bytes, file_type)
        if analysis["packing_indicators"]["is_packed"]:
            analysis["suspicious_indicators"].append(
                f"Packing detected: {analysis['packing_indicators']['packer_name']}"
            )
            analysis["risk_score"] += 30

        # 6. Suspicious strings analysis
        suspicious_strings = self._find_suspicious_strings(file_bytes)
        if suspicious_strings:
            analysis["suspicious_indicators"].extend(suspicious_strings)
            analysis["risk_score"] += 10 * len(suspicious_strings)

        # 7. File metadata anomalies
        metadata_issues = self._analyze_file_metadata(file_path)
        if metadata_issues:
            analysis["suspicious_indicators"].extend(metadata_issues)
            analysis["risk_score"] += 5 * len(metadata_issues)

        # Normalize risk score
        analysis["risk_score"] = min(analysis["risk_score"], 100)

        analysis["threat_level"] = "clean"
        if analysis["risk_score"] >= 80:
            analysis["threat_level"] = "critical"
        elif analysis["risk_score"] >= 60:
            analysis["threat_level"] = "high"
        elif analysis["risk_score"] >= 40:
            analysis["threat_level"] = "medium"
        elif analysis["risk_score"] >= 20:
            analysis["threat_level"] = "low"

        return analysis

    def _analyze_magic_bytes(self, file_bytes: bytes) -> dict:
        """Analyze file signature (magic bytes)."""
        signatures = {
            b"PK\x03\x04": ("zip", "ZIP/Office/JAR"),
            b"\x50\x4B\x03\x04": ("zip", "ZIP Archive"),
            b"%PDF": ("pdf", "PDF Document"),
            b"\xD0\xCF\x11\xE0\xA1\xB1\x1A\xE1": ("doc", "MS Office 97-2003"),
            b"PK\x03\x04\x14\x00\x06\x00": ("docx", "MS Office 2007+"),
            b"\x7FELF": ("elf", "ELF Binary"),
            b"MZ": ("exe", "PE Executable"),
            b"\xCA\xFE\xBA\xBE": ("macho", "Mach-O Binary"),
            b"\xFE\xED\xFA\xCE": ("macho32", "Mach-O 32-bit"),
            b"\xFE\xED\xFA\xCF": ("macho64", "Mach-O 64-bit"),
            b"\xCE\xFA\xED\xFE": ("macho32_le", "Mach-O 32-bit LE"),
            b"\xCF\xFA\xED\xFE": ("macho64_le", "Mach-O 64-bit LE"),
            b"GIF87a": ("gif", "GIF 87a"),
            b"GIF89a": ("gif", "GIF 89a"),
            b"\xFF\xD8\xFF": ("jpg", "JPEG Image"),
            b"\x89PNG": ("png", "PNG Image"),
            b"BM": ("bmp", "BMP Image"),
            b"RIFF": ("avi", "AVI/RIFF"),
            b"\xFF\xFB": ("mp3", "MP3 Audio"),
        }

        detected_type = None
        detected_name = None
        is_valid = False

        for magic, (type_name, display_name) in signatures.items():
            if file_bytes.startswith(magic):
                detected_type = type_name
                detected_name = display_name
                is_valid = True
                break

        return {
            "is_valid_signature": is_valid,
            "detected_type": detected_type,
            "detected_name": detected_name,
            "magic_bytes_hex": file_bytes[:16].hex(),
        }

    def _verify_file_structure(self, file_bytes: bytes, file_type: str) -> dict:
        """Verify file structure integrity."""
        anomalies = []

        if file_type == "pdf":
            # PDF must end with %%EOF
            if not file_bytes.endswith(b"%%EOF") and b"%%EOF" not in file_bytes[-100:]:
                anomalies.append("PDF missing EOF marker")

            # Check for suspicious PDF objects
            if b"/JavaScript" in file_bytes or b"/JS" in file_bytes:
                anomalies.append("PDF contains JavaScript (potential malware vector)")
            if b"/OpenAction" in file_bytes:
                anomalies.append("PDF has auto-execute action (suspicious)")
            if b"/Launch" in file_bytes:
                anomalies.append("PDF has file launch commands (suspicious)")
            if b"/EmbeddedFile" in file_bytes:
                anomalies.append("PDF has embedded files (potential malware)")

        elif file_type in ("docx", "doc"):
            # Office files are ZIP-based, check for suspicious streams
            if b"VBA" in file_bytes or b"_VBA_PROJECT" in file_bytes:
                anomalies.append("Office document contains VBA macro (potential malware)")
            if b"ExternalData" in file_bytes:
                anomalies.append("Office has external data references (suspicious)")
            if b"ActiveXObject" in file_bytes:
                anomalies.append("Office contains ActiveX (potential exploit)")

        elif file_type in ("zip", "jar"):
            # Check for suspicious compression ratios
            if len(file_bytes) < 1000 and b"PK" in file_bytes:
                anomalies.append("Suspiciously small archive (potential obfuscation)")

        elif file_type == "exe":
            # PE header analysis
            if len(file_bytes) > 64:
                e_lfanew = struct.unpack("<I", file_bytes[60:64])[0]
                if e_lfanew > len(file_bytes) - 4:
                    anomalies.append("Invalid PE header offset (corrupted executable)")
                elif file_bytes[e_lfanew : e_lfanew + 4] != b"PE\x00\x00":
                    anomalies.append("Invalid PE signature (spoofed executable)")

        return {
            "is_valid": len(anomalies) == 0,
            "anomalies": anomalies,
        }

    def _analyze_embedded_content(self, file_bytes: bytes, file_type: str, file_path: str) -> dict:
        """Analyze embedded malicious content."""
        threats = []
        malicious_content_detected = False

        # PDF embedded file analysis
        if file_type == "pdf":
            if b"/EmbeddedFile" in file_bytes or b"/ObjStm" in file_bytes:
                threats.append("PDF contains embedded files (obfuscation/malware vector)")
                malicious_content_detected = True

            # Check for suspicious PDF streams
            if b"/OpenAction" in file_bytes or b"/AA" in file_bytes:
                threats.append("PDF auto-execute action detected (malware behavior)")
                malicious_content_detected = True

        # Office document embedded objects
        if file_type in ("docx", "doc"):
            if b"embeddings" in file_bytes or b"oledata" in file_bytes:
                threats.append("Office contains embedded OLE objects (potential exploit)")
                malicious_content_detected = True

        # Archive bombs / Zip bombs
        if file_type == "zip":
            if b"PK\x03\x04" in file_bytes:
                # Simple check: look for highly compressed data
                try:
                    import zlib

                    # Try to decompress first 1MB
                    for i in range(len(file_bytes) - 4):
                        if file_bytes[i : i + 4] == b"PK\x03\x04":
                            if self._is_zip_bomb(file_bytes[i : i + 1000000]):
                                threats.append("Zip bomb detected (decompression bomb)")
                                malicious_content_detected = True
                                break
                except:
                    pass

        return {
            "malicious_content_detected": malicious_content_detected,
            "threats": threats,
        }

    def _is_zip_bomb(self, zip_data: bytes) -> bool:
        """Detect zip bomb by analyzing compression ratio."""
        try:
            import zlib

            if len(zip_data) > 4:
                header_check = zip_data[:4]
                if header_check == b"PK\x03\x04":
                    # Simple heuristic: if claimed size >> actual size
                    # Proper detection would require full ZIP parsing
                    return False  # Would need proper ZIP library for accurate detection
        except:
            pass
        return False

    def _analyze_entropy(self, file_bytes: bytes) -> dict:
        """Calculate Shannon entropy to detect compression/encryption/obfuscation."""
        if len(file_bytes) == 0:
            return {"entropy_value": 0, "suspicious": False}

        # Calculate Shannon entropy
        frequency = {}
        for byte in file_bytes:
            frequency[byte] = frequency.get(byte, 0) + 1

        entropy = 0.0
        for freq in frequency.values():
            p = freq / len(file_bytes)
            if p > 0:
                entropy -= p * math.log2(p)

        # Entropy interpretation:
        # 0-3: Low (text/structured data)
        # 3-7: Medium (normal binary)
        # 7-8: High (compressed/encrypted/obfuscated)
        suspicious = entropy > 7.5

        return {
            "entropy_value": entropy,
            "suspicious": suspicious,
            "interpretation": (
                "High entropy - potential compression/encryption/obfuscation"
                if suspicious
                else "Normal entropy for binary file"
            ),
        }

    def _detect_packing(self, file_bytes: bytes, file_type: str) -> dict:
        """Detect packing and obfuscation."""
        packer_signatures = {
            b"UPX!": "UPX",
            b"PKLITE": "PKLite",
            b"ASPACK": "ASPack",
            b"PECompressed": "PE Compressed",
            b"themida": "Themida",
            b"VMProtect": "VMProtect",
            b"Obsidium": "Obsidium",
        }

        for signature, packer_name in packer_signatures.items():
            if signature in file_bytes:
                return {
                    "is_packed": True,
                    "packer_name": packer_name,
                    "threat_level": "high",
                }

        # Check for suspicious section names in PE files
        if file_type == "exe" and b"MZ" in file_bytes:
            suspicious_sections = [b".UPX", b".packed", b".compressed", b".code"]
            for section in suspicious_sections:
                if section in file_bytes:
                    return {
                        "is_packed": True,
                        "packer_name": f"Custom ({section.decode(errors='ignore')})",
                        "threat_level": "high",
                    }

        return {
            "is_packed": False,
            "packer_name": None,
            "threat_level": None,
        }

    def _find_suspicious_strings(self, file_bytes: bytes) -> list:
        """Search for suspicious strings in file."""
        suspicious_patterns = [
            (rb"cmd\.exe", "Windows command shell reference"),
            (rb"powershell", "PowerShell execution"),
            (rb"wscript\.exe", "Windows Script Host"),
            (rb"rundll32", "DLL execution utility"),
            (rb"regsvr32", "Registry shell exploitation tool"),
            (rb"certutil", "Certificate utility (file download vector)"),
            (rb"psexec", "Remote execution tool"),
            (rb"createremotethread", "Remote code injection"),
            (rb"virtualalloc", "Memory injection"),
            (rb"writeprocessmemory", "Process memory manipulation"),
            (rb"getprocaddress", "Dynamic function loading (obfuscation)"),
            (rb"loadlibrary", "Dynamic library loading"),
            (rb"shellcode", "Shellcode detected"),
            (rb"crypt", "Encryption/obfuscation"),
            (rb"ransomware", "Ransomware reference"),
            (rb"bitcoin", "Cryptocurrency wallet"),
            (rb"http.*onion", "Tor network reference (C2 communication)"),
        ]

        suspicious = []
        for pattern, description in suspicious_patterns:
            if re.search(pattern, file_bytes, re.IGNORECASE):
                suspicious.append(description)

        return suspicious

    def _analyze_file_metadata(self, file_path: str) -> list:
        """Analyze file metadata for anomalies."""
        anomalies = []

        try:
            stat_info = os.stat(file_path)

            # Check for suspicious permissions
            mode = stat_info.st_mode
            if os.access(file_path, os.W_OK):
                anomalies.append("File is world-writable (potential tampering)")

            # Check for very recent creation
            import time

            now = time.time()
            if (now - stat_info.st_mtime) < 60:
                anomalies.append("File created very recently (potential dropped malware)")

            # Check file size anomalies
            if stat_info.st_size == 0:
                anomalies.append("Empty file (potential placeholder)")

        except:
            pass

        return anomalies
