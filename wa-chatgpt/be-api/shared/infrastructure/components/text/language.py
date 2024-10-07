from langchain.text_splitter import RecursiveTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings

def get_chunks_from_text(text: str) -> list[str]:
    splitter = RecursiveTextSplitter(
        chunk_size = 800,
        chunk_overlap = 100,
        length_function = len
    )
    return splitter.split_text(text)


# https://youtu.be/iDrpdkIHMq8?t=549
def get_embedding_by_minilm():
    model_name = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
    embeddings = HuggingFaceEmbeddings(model_name = model_name)
    return embeddings