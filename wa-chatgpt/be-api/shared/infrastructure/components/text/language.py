from langchain.text_splitter import RecursiveTextSplitter


def get_chunks_from_text(text: str) -> list[str]:
    splitter = RecursiveTextSplitter(
        chunk_size = 800,
        chunk_overlap = 100,
        length_function = len
    )
    return splitter.split_text(text)