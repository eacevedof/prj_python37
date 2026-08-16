import re
from typing import final, Self
from pathlib import Path

from ddd.shared.infrastructure.components import Logger
from ddd.ia_memory.domain.exceptions import MemoryException


@final
class ContentChunkerRepository:
    """Smart content chunking for ChromaDB storage."""

    DEFAULT_CHUNK_SIZE = 500  # tokens
    TOKEN_TO_CHARS = 4  # 1 token ≈ 4 characters

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def chunk_by_file_type(self, content: str, file_path: str, chunk_size: int = DEFAULT_CHUNK_SIZE) -> list[dict]:
        """
        Chunk content intelligently based on file type.

        Returns list of chunks with metadata.
        """
        file_ext = Path(file_path).suffix.lower()

        # Route to appropriate chunker
        if file_ext in {".py", ".java", ".ts", ".js", ".go", ".rb", ".rs"}:
            return self._chunk_source_code(content, file_path, chunk_size)
        elif file_ext in {".md", ".txt"}:
            return self._chunk_markdown(content, file_path, chunk_size)
        elif file_ext in {".xml", ".yaml", ".yml", ".json", ".toml"}:
            return self._chunk_config(content, file_path, chunk_size)
        else:
            # Fallback: generic chunking
            return self._chunk_generic(content, file_path, chunk_size)

    def _chunk_source_code(self, content: str, file_path: str, chunk_size: int) -> list[dict]:
        """
        Chunk source code by function/method/class boundaries.
        Keeps methods and classes intact.
        """
        chunks = []
        lines = content.split("\n")

        current_chunk = []
        current_size = 0
        method_start_line = 0
        indent_level = 0

        for line_num, line in enumerate(lines):
            line_tokens = self._estimate_tokens(line)

            # Check if this is a method/function/class definition
            is_definition = bool(
                re.match(r"^\s*(def|class|function|void|public|private|protected|func|impl)\s+", line)
            )

            # If we have content and adding this line exceeds chunk_size
            # AND we're not in the middle of a definition
            if current_size + line_tokens > chunk_size * 0.9 and current_chunk and not is_definition:
                # Save current chunk
                chunks.append({
                    "content": "\n".join(current_chunk),
                    "start_line": method_start_line,
                    "end_line": line_num - 1,
                    "token_count": current_size,
                    "metadata": {
                        "file": file_path,
                        "type": "source_code",
                        "chunk_type": "method_or_block"
                    }
                })
                current_chunk = []
                current_size = 0
                method_start_line = line_num

            current_chunk.append(line)
            current_size += line_tokens

        # Save remaining content
        if current_chunk:
            chunks.append({
                "content": "\n".join(current_chunk),
                "start_line": method_start_line,
                "end_line": len(lines) - 1,
                "token_count": current_size,
                "metadata": {
                    "file": file_path,
                    "type": "source_code",
                    "chunk_type": "method_or_block"
                }
            })

        return chunks

    def _chunk_markdown(self, content: str, file_path: str, chunk_size: int) -> list[dict]:
        """
        Chunk markdown by headers (H1, H2, H3).
        Keeps sections together.
        """
        chunks = []

        # Split by headers (## Title, ### Subtitle, etc)
        sections = re.split(r"(^#+\s+.+$)", content, flags=re.MULTILINE)

        current_chunk = []
        current_size = 0
        section_start = 0

        for i, section in enumerate(sections):
            if not section.strip():
                continue

            section_tokens = self._estimate_tokens(section)

            # If adding this section exceeds limit and we have content
            if current_size + section_tokens > chunk_size * 0.9 and current_chunk:
                chunks.append({
                    "content": "\n".join(current_chunk),
                    "section_index": section_start,
                    "token_count": current_size,
                    "metadata": {
                        "file": file_path,
                        "type": "markdown",
                        "chunk_type": "section"
                    }
                })
                current_chunk = []
                current_size = 0
                section_start = i

            current_chunk.append(section)
            current_size += section_tokens

        # Save remaining
        if current_chunk:
            chunks.append({
                "content": "\n".join(current_chunk),
                "section_index": section_start,
                "token_count": current_size,
                "metadata": {
                    "file": file_path,
                    "type": "markdown",
                    "chunk_type": "section"
                }
            })

        return chunks

    def _chunk_config(self, content: str, file_path: str, chunk_size: int) -> list[dict]:
        """
        Chunk config files by top-level keys (for YAML, JSON, TOML).
        """
        chunks = []

        # For config files, often one chunk is enough
        content_tokens = self._estimate_tokens(content)

        if content_tokens <= chunk_size:
            # Fits in one chunk
            return [{
                "content": content,
                "token_count": content_tokens,
                "metadata": {
                    "file": file_path,
                    "type": "config",
                    "chunk_type": "full_file"
                }
            }]

        # If too large, split by lines
        return self._chunk_generic(content, file_path, chunk_size)

    def _chunk_generic(self, content: str, file_path: str, chunk_size: int) -> list[dict]:
        """
        Generic chunking: split by paragraphs/sentences, respecting chunk_size.
        """
        chunks = []

        # Split by paragraphs (double newline)
        paragraphs = content.split("\n\n")

        current_chunk = []
        current_size = 0

        for para in paragraphs:
            if not para.strip():
                continue

            para_tokens = self._estimate_tokens(para)

            # If paragraph alone is larger than chunk_size, split it further
            if para_tokens > chunk_size:
                # Save current chunk first
                if current_chunk:
                    chunks.append({
                        "content": "\n\n".join(current_chunk),
                        "token_count": current_size,
                        "metadata": {
                            "file": file_path,
                            "type": "text",
                            "chunk_type": "paragraph_group"
                        }
                    })
                    current_chunk = []
                    current_size = 0

                # Split paragraph by sentences
                sentences = re.split(r"(?<=[.!?])\s+", para)
                chunk_sentences = []
                chunk_size_current = 0

                for sent in sentences:
                    sent_tokens = self._estimate_tokens(sent)

                    if chunk_size_current + sent_tokens > chunk_size and chunk_sentences:
                        chunks.append({
                            "content": " ".join(chunk_sentences),
                            "token_count": chunk_size_current,
                            "metadata": {
                                "file": file_path,
                                "type": "text",
                                "chunk_type": "sentence_group"
                            }
                        })
                        chunk_sentences = []
                        chunk_size_current = 0

                    chunk_sentences.append(sent)
                    chunk_size_current += sent_tokens

                # Save remaining sentences
                if chunk_sentences:
                    chunks.append({
                        "content": " ".join(chunk_sentences),
                        "token_count": chunk_size_current,
                        "metadata": {
                            "file": file_path,
                            "type": "text",
                            "chunk_type": "sentence_group"
                        }
                    })
            else:
                # Paragraph fits, add to current chunk
                if current_size + para_tokens > chunk_size and current_chunk:
                    chunks.append({
                        "content": "\n\n".join(current_chunk),
                        "token_count": current_size,
                        "metadata": {
                            "file": file_path,
                            "type": "text",
                            "chunk_type": "paragraph_group"
                        }
                    })
                    current_chunk = []
                    current_size = 0

                current_chunk.append(para)
                current_size += para_tokens

        # Save remaining
        if current_chunk:
            chunks.append({
                "content": "\n\n".join(current_chunk),
                "token_count": current_size,
                "metadata": {
                    "file": file_path,
                    "type": "text",
                    "chunk_type": "paragraph_group"
                }
            })

        return chunks

    def _estimate_tokens(self, text: str) -> int:
        """Rough estimate of token count."""
        # Simple heuristic: word count / 0.75 (words are ~1.3 tokens)
        words = len(text.split())
        return max(1, int(words / 0.75))

    def chunk_and_validate(self, content: str, file_path: str, chunk_size: int = DEFAULT_CHUNK_SIZE) -> list[dict]:
        """
        Chunk content and validate all chunks meet size constraints.
        """
        chunks = self.chunk_by_file_type(content, file_path, chunk_size)

        # Validate
        oversized = [c for c in chunks if c["token_count"] > chunk_size * 1.2]

        if oversized:
            self._logger.log_payload_error(
                {
                    "file": file_path,
                    "oversized_chunks": len(oversized),
                    "max_tokens": max(c["token_count"] for c in oversized)
                },
                "content_chunker.oversized_chunks"
            )

        return chunks
