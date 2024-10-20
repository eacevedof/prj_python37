from dataclasses import dataclass
from enum import Enum
from typing import final


@final
@dataclass(frozen=True)
class LangchainEmbeddingEnum(Enum):
    PARAPHRASE_MULTILINGUAL_MINILM_L12_V2 = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2" #471 MB
    PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2 = "sentence-transformers/paraphrase-multilingual-mpnet-base-v2" #1.2 GB
