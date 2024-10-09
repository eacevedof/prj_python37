from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import FAISS


def __get_chunks_from_text(text: str) -> list[str]:
    splitter = RecursiveCharacterTextSplitter(
        chunk_size = 800,
        chunk_overlap = 100,
        length_function = len
    )
    return splitter.split_text(text)


# https://youtu.be/iDrpdkIHMq8?t=549
def __get_embedding_by_minilm():
    model_name = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
    embeddings = HuggingFaceEmbeddings(model_name = model_name)
    return embeddings


def get_knowledge_base_from_text(text: str):
    chunks = __get_chunks_from_text(text)
    embeddings = __get_embedding_by_minilm()
    knowledge_base = FAISS.from_texts(chunks, embeddings)
    return knowledge_base

