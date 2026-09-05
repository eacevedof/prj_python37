from typing import List, Optional

# Orden de corte: se intenta partir por el separador mas "gordo" y solo se baja
# al siguiente cuando el trozo sigue pasandose de tamano. Es el criterio que
# usaba RecursiveCharacterTextSplitter de langchain.
DEFAULT_SEPARATORS = ["\n\n", "\n", " ", ""]


def split_text(
    text: str,
    chunk_size: int,
    chunk_overlap: int,
    separators: Optional[List[str]] = None
) -> List[str]:
    if chunk_overlap >= chunk_size:
        raise ValueError("text_splitter.chunk-overlap-must-be-lower-than-chunk-size")
    pieces = _split_by_separators(text, separators or DEFAULT_SEPARATORS, chunk_size)
    return _merge_pieces(pieces, chunk_size, chunk_overlap)


def _split_by_separators(text: str, separators: List[str], chunk_size: int) -> List[str]:
    if len(text) <= chunk_size:
        return [text] if text else []

    separator = separators[0]
    # ultimo recurso: no hay por donde cortar, se trocea a lo bruto
    if separator == "":
        return [text[i:i + chunk_size] for i in range(0, len(text), chunk_size)]

    pieces: List[str] = []
    for part in text.split(separator):
        if not part:
            continue
        if len(part) <= chunk_size:
            pieces.append(part)
        else:
            pieces.extend(_split_by_separators(part, separators[1:], chunk_size))
    return pieces


def _merge_pieces(pieces: List[str], chunk_size: int, chunk_overlap: int) -> List[str]:
    chunks: List[str] = []
    current = ""

    for piece in pieces:
        candidate = f"{current} {piece}" if current else piece
        if len(candidate) <= chunk_size:
            current = candidate
            continue

        if current:
            chunks.append(current)
        tail = current[-chunk_overlap:] if (current and chunk_overlap) else ""
        current = f"{tail} {piece}" if tail else piece

        # una pieza suelta que ya se pasa de tamano: se corta arrastrando el solape
        while len(current) > chunk_size:
            chunks.append(current[:chunk_size])
            current = current[chunk_size - chunk_overlap:]

    if current:
        chunks.append(current)
    return chunks
