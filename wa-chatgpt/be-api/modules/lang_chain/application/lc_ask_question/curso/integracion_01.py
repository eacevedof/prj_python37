from modules.lang_chain.infrastructure.repositories.lc_curso_repository import LcCursoRepository

def donde_se_encuentra_caceres() -> str:
    return LcCursoRepository.get_instance().donde_se_encuentra_caceres()