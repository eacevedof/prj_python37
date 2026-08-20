from typing import Any, Protocol


# Puerto: lo declara la fachada MCP (quien lo necesita) y lo cumple, sin saberlo,
# el adaptador de pdf_mod. No lleva @final por ser un port.
class PdfConversion(Protocol):
    """Puerto (dominio de pdf_mcp): convertir un Markdown local en PDF.

    La fachada sabe QUÉ se puede convertir; leer el fichero, renderizar el HTML
    y escribir el PDF son de `pdf_mod`.
    """

    async def convert_md_to_pdf(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
