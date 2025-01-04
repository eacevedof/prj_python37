from dataclasses import dataclass
from typing import List, final

from langchain_core.prompts import (
    BasePromptTemplate,
    PromptTemplate,
)
from langchain.schema import SystemMessage, HumanMessage
from langchain.prompts import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
    load_prompt,
)
from langchain.output_parsers import (
    CommaSeparatedListOutputParser,
    DatetimeOutputParser,
    OutputFixingParser,
)
from langchain.document_loaders import (
    CSVLoader,
    BSHTMLLoader,
    PyPDFLoader,
    WikipediaLoader,
    TextLoader,
)
from langchain.text_splitter import (
    CharacterTextSplitter,
)
from langchain.chains.llm import LLMChain
from langchain.chains.sequential import SimpleSequentialChain

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.files.filer import is_file, get_file_content

from modules.lang_chain.infrastructure.repositories.ejemplos_sklearn_repository import EjemplosSklearnRepository
from modules.lang_chain.infrastructure.repositories.abstract_langchain_repository import AbstractLangchainRepository


@final
@dataclass(frozen=True)
class LcCursoRepository(AbstractLangchainRepository):

    @staticmethod
    def get_instance() -> "LcCursoRepository":
        return LcCursoRepository()

    def ejemplo_cadena_secuencia_simple(self) -> str:
        open_ai_chat = self._get_chat_openai()
        prompt_conf = {
            "gimme-summary": LLMChain(
                llm=open_ai_chat,
                prompt=ChatPromptTemplate.from_template(
                    "Dame un simple resumen con un listado de puntos para un post de un blog acerca de {topic}"
                )
            ),
            "create-a-post": LLMChain(
                llm=open_ai_chat,
                prompt=ChatPromptTemplate.from_template(
                    "Escribe un post completo usando este resumen: {summary}"
                )
            ),
        }

        full_chain = SimpleSequentialChain(
            chains=[prompt_conf.get("gimme-summary"), prompt_conf.get("create-a-post")],
            verbose=True # nos ira dando paso a paso lo que se va haciendo
        )

        dic_response = full_chain.invoke(input="Inteligencia Artificial")

        return f"{dic_response.get("company_product")}: {dic_response.get("text")}"


    def ejemplo_creacion_objeto_llm_chain(self) -> str:
        prompt_conf = {
            "company_creator": {
                "human": {
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(
                        "Dame un nombre de compañia que sea simpatico para una compañia que cree {company_product}"
                    ),
                }
            },
        }
        chat_prompt_tpl = ChatPromptTemplate.from_messages([
            prompt_conf.get("company_creator").get("human").get("prompt_tpl"),
        ])

        # chat_prompt_formatted = chat_prompt_tpl.format_prompt(company_product="Lavadoras")
        # lm_input_request = chat_prompt_formatted.to_messages()

        llm_chain = LLMChain(llm=self._get_chat_openai(), prompt=chat_prompt_tpl)

        # el input se asocia al parametro del prompt. En este caso company_product
        dic_response = llm_chain.invoke(input="Lavadoras")

        return f"{dic_response.get("company_product")}: {dic_response.get("text")}"


    def ejemplo_compresion_y_optimizacion_de_resultados(self)-> str:
        sklearn_repository = EjemplosSklearnRepository.get_instance()

        vector_db = None
        consulta = "¿Por qué él lenguaje Python se llama así?"
        if sklearn_repository.db_optimization_exists():
            print("db optimization exists")
            vector_db = sklearn_repository.get_optimization_db()

        if not sklearn_repository.db_optimization_exists():
            print("creating optimization db")
            wikipedia_loader = WikipediaLoader(
                query="Lenguaje python",
                lang="es",
                load_max_docs = 5
            )
            wikipedia_data = wikipedia_loader.load()
            char_splitter = CharacterTextSplitter.from_tiktoken_encoder(chunk_size=500)
            wikipedia_chunks = char_splitter.split_documents(wikipedia_data)

            vector_db = sklearn_repository.create_optimization_db_by_documents(
                wikipedia_chunks
            )


        # esta no es la forma optimizada devuelve todo el contenido de wikipedia
        # matched_docs = vector_db.similarity_search(consulta)

        # en la forma optimizada se le solicita al llm de compresion y no la bd
        compression_retriever = sklearn_repository.get_compression_retriever()
        matched_docs = compression_retriever.invoke(consulta)

        print(matched_docs[0].page_content)
        return f"{consulta}\n{matched_docs[0].page_content}"

    def ejemplo_save_embeddings(self)-> str:
        sklearn_repository = EjemplosSklearnRepository.get_instance()

        vector_db = None
        consulta = "dame información de la Primera Guerra Mundial"
        if sklearn_repository.db_exists():
            consulta = "¿Qué pasó en el siglo de Oro?"
            print("db exists")
            vector_db = sklearn_repository.get_openai_db()

        if not sklearn_repository.db_exists():
            print("creating db")
            path = "./modules/lang_chain/application/lc_ask_question/curso/historia-espana.txt"
            texts = TextLoader(file_path=path, encoding="utf8").load()
            text_splitter = CharacterTextSplitter.from_tiktoken_encoder(chunk_size=500)
            vectorized_docs = text_splitter.split_documents(texts)
            vector_db = sklearn_repository.create_openai_db_by_documents(
                vectorized_docs
            )


        # busqueda seno. convierte consulta en un vector y lo comparará con lo que hay en la bd
        # recuperara los vectores que hablen de la Primera Guerra Mundial
        matched_docs = vector_db.similarity_search(consulta)

        print(matched_docs[0].page_content)
        return f"{consulta}\n{matched_docs[0].page_content}"


    def ejemplo_embeddings(self) -> str:
        csv_data = self.ejemplo_get_datos_ventas_small_con_csv_loader()
        openai_embeddings = self._get_embeddings_openai()
        embedded_docs = openai_embeddings.embed_documents([
            page.page_content for page in csv_data
        ])
        len(embedded_docs) # 22
        return embedded_docs[0]


    def ejemplo_transformer(self) -> str:
        path = "./modules/lang_chain/application/lc_ask_question/curso/historia-espana.txt"
        historia_espana = get_file_content(path)
        len(historia_espana) # 85369
        len(historia_espana.split(" ")) # 13701

        text_splitter = CharacterTextSplitter(
            separator = "\n",
            chunk_size = 1000
        )
        chunks = text_splitter.create_documents([historia_espana])
        print(type(chunks)) # <class 'list'>
        print(type(chunks[0]))
        return chunks[0].page_content


    def ejemplo_resumir_wikipedia(self) -> str:

        topic = "Fernando Alonso"
        user_question = "¿Cuándo nació?"

        language_code = "es"
        load_max_docs = 5

        wikipedia_loader = WikipediaLoader(
            query = topic,
            lang = language_code,
            load_max_docs = load_max_docs
        )
        wikipedia_data = wikipedia_loader.load()
        print(wikipedia_data[0].page_content)
        wiki_content = wikipedia_data[0].page_content # por optimizar solo pasamos el primer documento

        prompt_conf = {
            "wikipedia": {
                "human": {
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(
                        "Responde a esta pregunta:\n{human_question}, aquí tienes contenido extra:\n{context_info}"
                    ),
                }
            },
        }
        chat_prompt_tpl = ChatPromptTemplate.from_messages([
            prompt_conf.get("wikipedia").get("human").get("prompt_tpl"),
        ])
        chat_prompt_formatted = chat_prompt_tpl.format_prompt(
            context_info = wiki_content,
            human_question = user_question,
        )
        lm_input_request = chat_prompt_formatted.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        ai_wiki_response = ai_message.content

        return ai_wiki_response


    def ejemplo_resumir_pdf(self) -> str:

        prompt_conf = {
            "summarize": {
                "human": {
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(
                        "Necesito que hagas un resume del siguiente texto: \{pdf_content}"
                    ),
                }
            },
        }

        chat_prompt_tpl = ChatPromptTemplate.from_messages([
            prompt_conf.get("summarize").get("human").get("prompt_tpl"),
        ])

        path = "./modules/lang_chain/application/lc_ask_question/curso/documento-tecnologias-emergentes.pdf"
        pdf_content = self.__get_pdf_content(path)
        print(pdf_content)
        chat_prompt_formatted = chat_prompt_tpl.format_prompt(
            pdf_content = pdf_content
        )

        lm_input_request = chat_prompt_formatted.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        summarized_content = ai_message.content

        return summarized_content


    def __get_pdf_content(self, path: str) -> str:
        pdf_loader = PyPDFLoader(file_path=path)
        pdf_data = pdf_loader.load()
        pdf_content = []

        for page in pdf_data:
            pdf_content.append(page.page_content)

        return "\n".join(pdf_content)


    def ejemplo_get_html_con_bshtml_loader(self) -> str:
        path = "./modules/lang_chain/application/lc_ask_question/curso/ejemplo-web.html"
        bshtml_loader = BSHTMLLoader(path)
        html_data = bshtml_loader.load()

        return html_data[0].page_content


    def ejemplo_get_datos_ventas_small_con_csv_loader(self) -> List[dict]:
        path = "./modules/lang_chain/application/lc_ask_question/curso/datos-ventas-small.csv"
        csv_loader = CSVLoader(
            file_path = path,
            csv_args = {"delimiter": ";"}
        )
        csv_data = csv_loader.load()
        # csv_data[0] es de tipo langchain.documents.base.Document
        print(csv_data[1].page_content)
        return csv_data

    def ejemplo_prompt_tamplate_save(self) -> str:
        prompt_conf = {
            "history": {
                "human": {
                    "user_question": "Cómo se prepara un bizcocho de vainilla",
                    "str_prompt_tpl": "Pregunta: {user_question}\n\nRespuesta: Vamos a verlo paso a paso",
                }
            },
        }
        self.__save_prompt_tpl_independece_day(
            prompt_conf.get("history").get("human").get("str_prompt_tpl")
        )
        chat_prompt_tpl = self.__get_independence_day_saved_prompt()

        chat_prompt_formatted = chat_prompt_tpl.format_prompt(
            user_question = prompt_conf.get("history").get("human").get("user_question"),
        )

        lm_input_request = chat_prompt_formatted.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        str_response = ai_message.content

        return str_response

    def __save_prompt_tpl_independece_day(self, tpl: str) -> None:
        chat_prompt_tpl = PromptTemplate(
            template = tpl
        )
        chat_prompt_tpl.save("history-independence-day.json")

    def __get_independence_day_saved_prompt(self) -> BasePromptTemplate:
        return load_prompt("history-independence-day.json")


    def ejemplo_template_system_prompt(self) -> str:
        prompt_conf = {
            "history": {
                "system": {
                    "prompt_tpl": SystemMessagePromptTemplate.from_template(
                        "Tienes que responder únicamente con un patrón de fechas"
                    ),
                },
                "human": {
                    "request": "¿Cuando es el día de la declaración de la independencia de los EEUU",
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(
                        "{request}\n{format_instructions}"
                    ),
                }
            },
        }

        chat_prompt_tpl = ChatPromptTemplate.from_messages([
            prompt_conf.get("history").get("system").get("prompt_tpl"),
            prompt_conf.get("history").get("human").get("prompt_tpl"),
        ])

        dt_output_parser = DatetimeOutputParser()
        chat_prompt_formatted = chat_prompt_tpl.format_prompt(
            request = prompt_conf.get("history").get("human").get("request"),
            format_instructions = dt_output_parser.get_format_instructions()
        )

        lm_input_request = chat_prompt_formatted.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        str_dt_unformatted = ai_message.content # 1776-07-04T00:00:00:00000Z
        dt_independence_day = dt_output_parser.parse(str_dt_unformatted) # datetime.datetime(1776, 7, 4, 0, 0)
        print(dt_independence_day) # 1776-07-04 00:00:00

        return dt_independence_day.strftime("%Y-%m-%d")

    def ejemplo_parser_auto_fix(self) -> str:
        str_human_template = "{request}\n{format_instructions}"
        prompt_conf = {
            "history": {
                "human": {
                    "request": "¿Cuando es el día de la declaración de la independencia de los EEUU",
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(str_human_template),
                }
            },
        }

        chat_prompt_tpl = ChatPromptTemplate.from_messages([
            prompt_conf.get("history").get("human").get("prompt_tpl"),
        ])

        dt_output_parser = DatetimeOutputParser()
        chat_prompt_formatted = chat_prompt_tpl.format_prompt(
            request = prompt_conf.get("history").get("human").get("request"),
            format_instructions = dt_output_parser.get_format_instructions()
        )

        openai_chat = self._get_chat_openai()
        lm_input_request = chat_prompt_formatted.to_messages()

        ai_message = openai_chat.invoke(lm_input_request)
        str_dt_unformatted = ai_message.content # 1776-07-04T00:00:00:00000Z
        fixing_parser = OutputFixingParser.from_llm(
            parser = dt_output_parser,
            llm = openai_chat,
        )

        dt_independence_day = fixing_parser.parse(str_dt_unformatted) # datetime.datetime(1776, 7, 4, 0, 0)
        print(dt_independence_day) # 1776-07-04 00:00:00

        return dt_independence_day.strftime("%Y-%m-%d")


    def ejemplo_parser_fecha(self) -> str:
        str_human_template = "{request}\n{format_instructions}"
        prompt_conf = {
            "history": {
                "human": {
                    "request": "¿Cuando es el día de la declaración de la independencia de los EEUU",
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(str_human_template),
                }
            },
        }
        chat_prompt_tpl = ChatPromptTemplate.from_messages([
            prompt_conf.get("history").get("human").get("prompt_tpl"),
        ])
        dt_output_parser = DatetimeOutputParser()

        chat_prompt_formatted = chat_prompt_tpl.format_prompt(
            request = prompt_conf.get("history").get("human").get("request"),
            format_instructions = dt_output_parser.get_format_instructions(),
        )
        lm_input_request = chat_prompt_formatted.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        str_dt_unformatted = ai_message.content # 1776-07-04T00:00:00:00000Z

        dt_independence_day = dt_output_parser.parse(str_dt_unformatted)
        print(dt_independence_day) # 1776-07-04 00:00:00

        return dt_independence_day.strftime("%Y-%m-%d")


    def ejemplo_parsear_salida_de_caracteristicas_coches(self) -> str:
        str_human_template = "{request}\n{format_instructions}"
        prompt_conf = {
            "car_specialist": {
                "human": {
                    "request": "dime 5 caracteresticas de los coches americanos",
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(str_human_template),
                }
            },
        }
        chat_prompt = ChatPromptTemplate.from_messages([
            prompt_conf.get("car_specialist").get("human").get("prompt_tpl"),
        ])
        csv_output_parser = CommaSeparatedListOutputParser()

        chat_prompt_value = chat_prompt.format_prompt(
            request = prompt_conf.get("car_specialist").get("human").get("request"),
            format_instructions = csv_output_parser.get_format_instructions(),
        )

        lm_input_request = chat_prompt_value.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        str_content = ai_message.content
        lst_content = csv_output_parser.parse(str_content)
        Log.log_debug(lst_content, "lst_content")

        return str_content


    def ejemplo_parsear_salida(self) -> List[str]:
        csv_output_parser = CommaSeparatedListOutputParser()
        # las instrucciones nos indica que formato de entrada debe tener la respuesta
        format_instructions = csv_output_parser.get_format_instructions()
        respuesta = "coche, árbol, carretera"
        return csv_output_parser.parse(respuesta)


    def ejemplo_prompt_template_especialista_en_coches(self) -> str:
        str_sys_template = "Eres una IA especializada en coches de tipo {car_type} y generar artículos que leen en {read_time}"
        str_human_template = "Necesito un artículo para vehículos con motor {motor_type}"

        prompt_conf = {
            "car_specialist": {
                "system": {
                    "prompt_tpl": SystemMessagePromptTemplate.from_template(str_sys_template),
                },
                "human": {
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(str_human_template),
                }
            },
        }
        chat_prompt = ChatPromptTemplate.from_messages([
            prompt_conf.get("car_specialist").get("system").get("prompt_tpl"),
            prompt_conf.get("car_specialist").get("human").get("prompt_tpl"),
        ])

        chat_prompt_value = chat_prompt.format_prompt(
            motor_type="hibrido enchufable",
            read_time="3 min",
            car_type="japoneses",
        )
        lm_input_request = chat_prompt_value.to_messages()
        ai_message = self._get_chat_openai().invoke(lm_input_request)
        return ai_message.content


    def ejemplo_multi_rol_con_generate(self) -> dict:
        prompt_conf = {
            "history": {
                "system_role": "Eres un historiador que conoce los detalles de todas las ciudades del mundo",
                "question": "¿Puedes decirme dónde se encuentra Cáceres?",
            },
            "rude_young_person": {
                "system_role": "Eres un joven rudo que no le gusta que le pregunten, solo quiere estar de fiesta",
                "question": "¿Puedes decirme dónde se encuentra Cáceres?",
            }
        }
        llm_result = self._get_chat_openai().generate([
          [
              SystemMessage(content=prompt_conf.get("history").get("system_role")),
              HumanMessage(content=prompt_conf.get("history").get("question"))
          ],
          [
              SystemMessage(content=prompt_conf.get("rude_young_person").get("system_role")),
              HumanMessage(content=prompt_conf.get("rude_young_person").get("question"))
          ],
        ])
        generated_texts = llm_result.generations
        return {
            "history": {
                "question": prompt_conf.get("history").get("question"),
                "response": generated_texts[0][0].text,
            },
            "rude_young_person": {
                "question": prompt_conf.get("rude_young_person").get("question"),
                "response": generated_texts[1][0].text,
            },
        }


    def donde_se_encuentra_lima_system_human_message(self) -> str:
        str_content = "¿Puedes decirme dónde se encuentra Lima?"
        human_message = HumanMessage(content=str_content)

        system_rol = "Eres un historiador que conoce los detalles de todas las ciudades del mundo"
        system_message = SystemMessage(content=system_rol)

        ai_message = self._get_chat_openai().invoke([
            system_message,
            human_message
        ])
        return ai_message.content


    def donde_se_encuentra_caceres_only_human_message(self) -> str:
        str_content = "¿Puedes decirme dónde se encuentra Cáceres?"
        human_message = HumanMessage(content=str_content)
        ai_message = self._get_chat_openai().invoke([human_message])
        return ai_message.content
