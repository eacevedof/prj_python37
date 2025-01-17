### code
- https://github.com/eacevedof/prj_python37/tree/master/wa-chatgpt/be-api/modules/lang_chain/application/lc_ask_question
- [curso](https://www.udemy.com/course/langchain-y-llm-desarrolla-aplicaciones-de-ia-en-python/learn/lecture/45189465)

### prompt formula
```
- escribe un resumen de lo que quieres que haga el modelo
- Al GPT: 
    - actua como un ingeniero em prompt
    - revisa este prompt
    - optimizalo para hacerlo mejor
    - hazme preguntas antes de proceder
```

### Neurona artificial:
- ![Artificial neuron](./images/artificial-neuron.png)
- Es una representacion matematica de una neurona biologica
- Una neurona se compone de:
  1. Xn entradas
  2. Wi pesos 
  3. Bj bias (sesgo)
  4. f **funcion de activación**
    - aplica funciones matematicas complejas que evitan la linealidad en el modelo
    - Ejemplos:
      - Sigmoide: ![Sigmoide](./images/fn-sigmoid.png)
      - Tangente hiperbolica:  ![Tangente hiperbolica](./images/fn-hyperbolic-tangent.png)
      - ... reul, leaky ReLU, etc cada una se ajusta a un tipo de problema
  5. Output

### Red de neuronas:
- Se compone de:
  - Red de neuronas para aceptar datos de entreda.
  - Red capa oculta para el procesamiento de cada una de las etapas.
  - Neurona de salida.

### Transformer:
- ![transformer](./images/transformer.png)
- Red neuronal que consta de dos capas.
- Capa de codificacion.
  - Codifica la entrada y en el contexto que se ha proporionado en un set de vecotes 
- Capa de decodificacion.
- **Mecanismo de atención**
  - El mecanismo de atención es la base del modelo Transformer, donde se utiliza la variante llamada self-attention o atención propia. Este mecanismo permite que el modelo analice cómo cada palabra en una oración está relacionada con otras palabras en la misma oración.
  - Es una herramienta poderosa que ayuda a los modelos de IA a comprender mejor las entradas, enfocándose en lo relevante y descartando lo redundante o menos importante

## Langchain
- Framework para desarrollar apps impulsadas por LLMs.
- Consta de módulos o componentes.
- [https://python.langchain.com](https://python.langchain.com/docs/introduction/)
- Proveedores con los que langchain tiene conectividad:
  - [https://python.langchain.com/docs/integrations/providers/](https://python.langchain.com/docs/integrations/providers/)

### Componentes:
- ![langchain components](./images/langchain-components.png)
- **Modelo IO**. 
  - Componente que sigue un estandar tipo interfaz que permite ser sustituido por otro modelo. 
- **Conectores de datos**
  - Conecta un modelo LLM a una fuente de datos. 
- **Cadenas**
  - Permite enlazar salidas de un llm con entradas de otro. Pe. App que en primera fase resume un contenido de texto y seguidamente lo
  traduce a otro idioma.
- **Memoria** 
  - Permite que retenga un contexto historico de interacciones. 
- **Agentes**
  - Van a ser capaces de disernir entre diferentes tipos de herramientas cual es la más adecuada para la solicitud que se le hace.

### Casos de uso:
- Aplicaciones de preguntas y respuestas
- Resumir información
- Consultar bases de datos
- Consulta a bds
- Interaccion con apis
- Agentes
- Chatbots

- Langchain necesita poder enviar texto al LLM y también recibir y trabajar con sus resultados.
- El uso de LC y el componente **Modelo IO** nos permitirá construir cadenas más adelante, pero también nos 
dará más flexibilidad para cambiar de proveedor de LLM en el futuro por cumplir con la interfaz
- En las solicitudes API debemos tener en cuenta dos parámetros importantes:
  - **system message**
    - cómo se debe comportar el LLM 
  - **human message**
    - solicitud del usuario 
- [Api con chat models](https://python.langchain.com/docs/integrations/chat/)
  - Ejemplo [**Chat Open AI**](https://python.langchain.com/api_reference/openai/chat_models/langchain_openai.chat_models.base.ChatOpenAI.html)

### ejemplos 
- **invoke**
- invoke trata solo un mensaje
- aplicando un rol al sistema la respesta tendrá un mejor contexto
```python
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
```
- ![ai-message](./images/ai-message.png)
- **generate**
- multiples mensajes con multiples roles
```python
  def ejemplo_multi_rol_con_generate(self) -> dict:
      dic_prompt = {
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
            SystemMessage(content=dic_prompt.get("history").get("system_role")),
            HumanMessage(content=dic_prompt.get("history").get("question"))
        ],
        [
            SystemMessage(content=dic_prompt.get("rude_young_person").get("system_role")),
            HumanMessage(content=dic_prompt.get("rude_young_person").get("question"))
        ],
      ])
      generated_texts = llm_result.generations
      return {
          "history": {
              "question": dic_prompt.get("history").get("question"),
              "response": generated_texts[0][0].text,
          },
          "rude_young_person": {
              "question": dic_prompt.get("rude_young_person").get("question"),
              "response": generated_texts[1][0].text,
          },
      }
```
- respuesta:
- ![lc-chat-generate-result](./images/lc-chat-generate-result.png)
- ![lc-chat-generate-result](./images/postman-lc-chat-generate-result.png)

### Plantillas de prompts
- Permiten modificar nuestras indicaciones de entrada al LLM fácilmente.
- Ofrencen un enfoque más estructurado para pasar entradas formateadas evitando formalizarlas con `f o xxx.format()`
ya que **PromptTemplate** las convierte en nombres de parámetros de función que podemos pasar.
- Es recomendable usar las plantillas para estandarizar los mensajes entre las distintas apps.
```python
def ejemplo_prompt_template_especialista_en_coches(self) -> str:
    str_sys_template = "Eres una IA especializada en coches de tipo {car_type} y generar artículos que leen en {read_time}"
    str_human_template = "Necesito un artículo para vehículos con motor {motor_type}"

    dic_prompt = {
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
        dic_prompt.get("car_specialist").get("system").get("prompt_tpl"),
        dic_prompt.get("car_specialist").get("human").get("prompt_tpl"),
    ])

    chat_prompt_value = chat_prompt.format_prompt(
        motor_type="hibrido enchufable",
        read_time="3 min",
        car_type="japoneses",
    )
    final_request = chat_prompt_value.to_messages()
    ai_message = self._get_chat_openai().invoke(final_request)
    return ai_message.content
```
- ![chat-prompt-template](./images/chat-prompt-template.png)
- ![prompt-template-config](./images/prompt-template-config.png)
- ![chat-prompt-value](./images/chat-prompt-value.png)

### Parsear y procesar la salida
```python
from langchain.output_parsers import (
    CommaSeparatedListOutputParser,
    DatetimeOutputParser,
    OutputFixingParser
)
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
```
### serializacion de prompts
- Permite guardar plantillas complejas en formato JSON para su reutilización.
```python
from langchain_core.prompts import (
    BasePromptTemplate,
    PromptTemplate
)
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
```
- ejemplo **history-independence-day.json**
```json
{
    "name": null,
    "input_variables": [
        "user_question"
    ],
    "optional_variables": [],
    "output_parser": null,
    "partial_variables": {},
    "metadata": null,
    "tags": null,
    "template": "Pregunta: {user_question}\n\nRespuesta: Vamos a verlo paso a paso",
    "template_format": "f-string",
    "validate_template": false,
    "_type": "prompt"
}
```
### conectores de datos
- ![data-connectors](./images/data-connectors.png)
#### cargadores de documentos (loaders)
- Langchain viene con herramientas de carga integradas. Estas son librerias que mapean un tipo de documento 
a nivel de infraestructura con un objeto de python.
- `pip install langchain-community` con esto se instala algunos loaders
- [documentación loaders](https://python.langchain.com/docs/how_to/#document-loaders)
```python
from langchain.document_loaders import (
    CSVLoader,
    BSHTMLLoader
)

def ejemplo_get_datos_ventas_small_con_loader(self) -> List[dict]:
    path = "./modules/lang_chain/application/lc_ask_question/curso/datos-ventas-small.csv"
    csv_loader = CSVLoader(
        file_path = path,
        csv_args = {"delimiter": ";"}
    )
    csv_data = csv_loader.load()
    print(csv_data[1].page_content)
    return csv_data

def ejemplo_get_html_con_bshtml_loader(self) -> str:
    path = "./modules/lang_chain/application/lc_ask_question/curso/ejemplo-web.html"
    bshtml_loader = BSHTMLLoader(path)
    html_data = bshtml_loader.load()

    return html_data[0].page_content
```
- **html loaded**
- ![html-data-loaded](./images/html-data-loaded.png)
- **resumir contenido de un pdf**
- ![pypdf-data-loaded](./images/pypdf-data-loaded.png)
```python
from langchain.document_loaders import (
    PyPDFLoader
)

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
```
![postman pdf summarized](./images/postman-pdf-summarized.png)

### cargadores de tipo integración (integration loaders)
- Permite la carga de fuente de datos concreta.
- Ejemplo: AWS, Google Drive, Dropbox, MongoDB, Wikipedia, Youtube, Azure, etc
- Son abstracciones de tipo repositiorio que permiten solicitar información de estos servicios externos.
```python
# pip install wikipedia
from langchain.document_loaders import WikipediaLoader
def ejemplo_resumir_wikipedia(self) -> str:

    topic = "Fernando Alonso"
    user_question = "¿Cuándo nació?"

    lang = "es"
    load_max_docs = 5

    wikipedia_loader = WikipediaLoader(
        query = topic,
        lang = lang,
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
```
![postman ask wikipedia](./images/postman-ask-wikipedia.png)

#### transformacion de documentos 
- son troceadores semanticos de información en **chunks**
- Viene a solucionar el límite de información soportado por un modelo.
- Este límite esta en el rango de 8K tokens +/- 6K palabras.
- Estos chunks serviran en su forma vectorial (embeddings) para buscar similitudes de acuerdo a su distancia
- Por ejemplo, podremos alimentar un modelo LLM con contexto adicional para afinar su respuesta.
```python
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
```
#### incrustación de textos y creación de vectores (embeddings)
- ![embeddings](./images/embeddings.png)
```python
def ejemplo_embeddings(self) -> str:
    csv_data = self.ejemplo_get_datos_ventas_small_con_csv_loader()
    openai_embeddings = self._get_embeddings_openai()
    embedded_docs = openai_embeddings.embed_documents([
        page.page_content for page in csv_data
    ])
    len(embedded_docs) # 22
    return embedded_docs[0]
```
- ![embedded docs](./images/embedded-docs.png)
#### almacenamiento de vectores en base de datos
- hasta ahora hemos generado los **embeddings** en tiempo real, es decir en RAM.
- Podemos almacenar estos vectores en una **base de datos de vectores** 
- caracterisiticas de bases de datos vectoriales:
![almacenamiento de vectores en base de datos](./images/almacenamiento-de-vectores-en-base-de-datos.png)
![proceso de persistencia de vectores](./images/proceso-de-persistencia-de-vectores.png)
- Una vez que se tenga el contenido de un texto en vectores cuando se haga una consulta sobre este se podra
obtener los documentos más similares a este (ranking)
```python
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
```
- parquet example
![db parquet format example](./images/db-parquet-format.png)
![postman db response](./images/postman-db-parquet-response.png)

#### compresion y optimizacion de resultados
- ![compression](./images/compresion-and-result-optimization.png)
```python
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
```
## cadenas en langchain
- **modelo secuencial simple**
- ![modelo-secuencial-simple](./images/llm-simple-chain.png)
```python
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
        verbose=True # nos ira dando paso a paso lo que se va haciendo por consola
    )

    dic_response = full_chain.invoke(input="Inteligencia Artificial")

    return f"{dic_response.get("input")}:\n{dic_response.get("output")}"
```
#### modelo secuencial completo
- ![full secuencial model](./images/full-secuencial-model.png)
```python
from langchain.chains import SequentialChain

def ejemplo_cadena_secuencia_completo(self) -> str:
    open_ai_chat = self._get_chat_openai()
    prompt_conf = {
        "employee-performance": LLMChain(
            llm = open_ai_chat,
            prompt = ChatPromptTemplate.from_template(
                "Dame un resumen del rendimiento de este trabajador:\n{performance_review}"
            ),
            output_key = "employee_performance",
        ),
        "employee-weaknesses": LLMChain(
            llm = open_ai_chat,
            prompt = ChatPromptTemplate.from_template(
                "Identifica las debilidades de este trabajador dentro de de este resumen de la revisión:\n{employee_performance}"
            ),
            output_key = "employee_weaknesses",
        ),
        "improve-plan":  LLMChain(
            llm = open_ai_chat,
            prompt = ChatPromptTemplate.from_template(
                "Crea un plan de mejora para ayudar en estas debilidades:\n{employee_weaknesses}"
            ),
            output_key="improve_plan",
        ),
    }

    full_chain = SequentialChain(
        chains=[prompt_conf.get("employee-performance"), prompt_conf.get("employee-weaknesses"), prompt_conf.get("improve-plan")],
        input_variables=["performance_review"],
        output_variables=["employee_performance", "employee_weaknesses", "improve_plan"],
        verbose=True,
    )

    # esto podria venir de una base de datos
    performance_review = '''
Revisión de Rendimiento del Empleado

Nombre del Empleado: Juan Pérez,
Posición: Analista de Datos,
Período Evaluado: Enero 2023 - Junio 2023,

Fortalezas:
Juan ha demostrado un fuerte dominio de las herramientas analíticas y ha proporcionado informes detallados y precisos 
que han sido de gran ayuda para la toma de decisiones estratégicas. Su capacidad para trabajar en equipo y su disposición 
para ayudar a los demás también han sido notables. Además, ha mostrado una gran ética de trabajo y una actitud positiva 
en el entorno laboral.

Debilidades:
A pesar de sus muchas fortalezas, Juan ha mostrado áreas que necesitan mejoras. En particular, se ha observado que a 
veces tiene dificultades para manejar múltiples tareas simultáneamente, lo que resulta en retrasos en la entrega de proyectos. 
También ha habido ocasiones en las que la calidad del trabajo ha disminuido bajo presión. Además, se ha identificado 
una necesidad de mejorar sus habilidades de comunicación, especialmente en lo que respecta a la presentación de datos 
complejos de manera clara y concisa a los miembros no técnicos del equipo. Finalmente, se ha notado una falta de proactividad 
en la búsqueda de soluciones a problemas imprevistos, confiando a menudo en la orientación de sus superiores en lugar 
de tomar la iniciativa.        
    '''

    dic_response = full_chain.invoke(performance_review)

    return f"{dic_response.get("performance_review")}:\n{dic_response.get("employee_performance")}\n{dic_response.get("employee_weaknesses")}\n{dic_response.get("improve_plan")}"
```
![full sequential model](./images/postman-full-sequential-model.png)

#### Enrutamiento a cadenas con LLMRouterChain
- ![llm-router-chain](./images/llm-router-chain.png)
```python
from langchain.chains.router.llm_router import (
    LLMRouterChain,
    RouterOutputParser
)
from langchain.chains.router import MultiPromptChain

def ejemplo_enrutamiento_de_cadenas(self) -> str:
    plantilla_soporte_basico = '''
Eres una persona que asiste a los clientes de automóviles con preguntas básicas que pueden,
necesitar en su día a día y que explica los conceptos de una manera que sea simple de entender. 
Asume que no tienen conocimiento,previo. Esta es la pregunta del cliente/n{input}
'''
    plantilla_soporte_avanzado_mecanico = '''
Eres un experto en mecánica que explicas consultas avanzadas a los mecánicos,
de la plantilla. Puedes asumir que cualquier que está preguntando tiene conocimientos avanzados de mecánica.
Esta es la pregunta del cliente/n{input}
'''
    prompt_info = [
        {
            "name": "mecánica básica", "description": "Responde preguntas básicas de mecánica a clientes",
            "prompt_template": plantilla_soporte_basico,
        },
        {
            "name": "mecánica avanzada", "description": "Responde preguntas avanzadas de mecánica a a expertos con conocimiento previo",
            "prompt_template": plantilla_soporte_avanzado_mecanico,
        },
    ]

    destination_chains = {}
    chat_open_ai = self._get_chat_openai()
    for p_info in prompt_info:
        name = p_info.get("name")
        prompt_template = p_info.get("prompt_template")
        chat_prompt_tpl = ChatPromptTemplate.from_template(prompt_template)
        llm_chain = LLMChain(llm = chat_open_ai, prompt = chat_prompt_tpl)
        destination_chains[name] = llm_chain

    destinations = [f"{p["name"]}: {p["description"]}" for p in prompt_info]
    str_destinations = "\n".join(destinations)

    router_template = MULTI_PROMPT_ROUTER_TEMPLATE.format(destinations=str_destinations) # el parametro importante es el "destinations" , debemos formatearlo en tipo string
    router_prompt_tpl = PromptTemplate(
        template=router_template,
        input_variables=["input"],
        output_parser=RouterOutputParser(),  #para transformar el objeto JSON parseandolo a una string
    )
    router_chain = LLMRouterChain.from_llm(llm=chat_open_ai, prompt=router_prompt_tpl)

    # creamos el prompt y cadena por defecto puesto que son arumentos obligatorios que usaremos posteriormente
    default_chain = LLMChain(
        llm=chat_open_ai,
        prompt=ChatPromptTemplate.from_template("{input}")
    )
    llm_chain = MultiPromptChain(
        router_chain = router_chain,
        destination_chains=destination_chains, # los llms con los roles de niveles de respuesta,
        default_chain=default_chain, #la entrada principal
        verbose=True,
    )

    # dic_response = llm_chain.invoke("¿Cómo cambio el aceite de mi coche?")  # input de mecanica basica
    dic_response = llm_chain.invoke("¿Cómo funciona un catalizador?") # input de mecanica avanzada

    return f"{dic_response.get("input")}:\n{dic_response.get("text")}"
```
- ![llm router no expert](./images/postman-router-chain-no-expert.png)
- ![llm router expert](./images/postman-router-chain-expert.png)

#### cadenas de transformacion
- Son clases que llevan una funcion de callback como argumento al que invocan para aplicar la transformacion correspondiente
- ![transformation-chains](./images/llm-transformation-chains.png)
```python
from langchain.chains.transform import TransformChain

def ejemplo_cadenas_transformacion(self) -> str:
    wikipedia_query = "Real Madrid"
    final_language = "francés"

    wikip_loader = WikipediaLoader(query=wikipedia_query, lang="es", load_max_docs=1)
    wikipedia_data = wikip_loader.load()

    # el texto del primer documento es muy grande y no lo necesitamos todo
    wiki_page1 = wikipedia_data[0].page_content
    print(f"texto-wiki-page1: {wiki_page1}")

    def fn_get_first_paragraph(inputs: dict) -> dict:
        texto = inputs.get("texto")
        primer_parrafo = texto.split("\n")[0]
        print(f"primer_parrafo: {primer_parrafo}")
        return {
            "salida": primer_parrafo
        }

    transform_chain = TransformChain(
        input_variables = ["texto"],
        output_variables = ["salida"],
        transform = fn_get_first_paragraph # aunque no lo detecta como un argumento lo construye en ejecución a partir de kwargs
    )

    chat_open_ai = self._get_chat_openai()
    llm_chain = {
        "create-summary": LLMChain(
            llm=chat_open_ai,
            prompt=ChatPromptTemplate.from_template("Crea un resumen de este texto:\n{texto}"),
            output_key="summary_text"
        ),
        "translate": LLMChain(
            llm=chat_open_ai,
            # texto vendra de la cadena 1 (create-summary)
            prompt=ChatPromptTemplate.from_template("Traduce este texto al "+final_language+" el siguiente texto:\n{texto}"),
            output_key="translated_text"
        )
    }

    # no entiendo esta parte que hace? devuelve una clase del mismo tipo?
    simple_sequential_chain = SimpleSequentialChain(
        chains = [transform_chain, llm_chain.get("create-summary"), llm_chain.get("translate")],
        verbose = True
    )

    # aqui llama a simple_sequential_chain.__call__
    dic_response = simple_sequential_chain(wiki_page1)

    # return f"{dic_response.get("input")}\n{dic_response.get("output")}"
    return f"{wikipedia_query} ({final_language})\n{dic_response.get("output")}"
```
- ![debug transformation-chains](./images/debug-transformation-chains.png)
- ![postman transformation-chains](./images/postman-transformation-chains.png)

#### cadenas para preguntas y respuestas de nuestros datos
- ![Q & A chains](./images/q-and-a-chains.png)
-  **ejemplo run**
```python
def ejemplo_preguntas_y_respuestas(self) -> str:
    sklearn_repository = EjemplosSklearnRepository.get_instance()
    qa_db = sklearn_repository.get_q_and_a_connection()
    chat_open_ai = self._get_chat_openai()

    # stuff: se usa cuando se desea una manera simple y directa de cargar y procesar el contenido completo sin dividirlo
    # en fragmentos más pequeños. Es ideal para situaciones donde el volumen de datos no es demasiado grande y se
    # puede manejar de manera eficiente por el modelo de lenguaje en una sola operación.
    qa_chain = load_qa_chain(llm=chat_open_ai, chain_type="stuff")

    question = "Qúe pasó en el siglo de oro?"
    # documentos ranqueados por busqueda de similitud seno
    docs = qa_db.similarity_search(question)

    # no usamos compresion como vimos en el ejemplo anterior
    str_ia_response = qa_chain.run(input_documents=docs, question=question)

    return str_ia_response
```
![Q & A chains by run](./images/debug-q-and-a-chain-run.png)
![postman q and a](./images/postman-q-and-a-chain-run.png)
- **ejemplo invoke**
```python
  question = "Qúe pasó en el siglo de oro?"
  # documentos ranqueados por busqueda de similitud seno
  docs = qa_db.similarity_search(question)
  
  # no usamos compresion como vimos en el ejemplo anterior
  dic_response = qa_chain.invoke({
      "input_documents": docs,
      "question": question
  })
  
  return f"{dic_response.get("question")}\n{dic_response.get("output_text")}"
```
### memoria
![memory scope](./images/memory-scope.png)
```python
from langchain.memory import ChatMessageHistory

def ejemplo_chat_messge_history(self) -> str:

    human_query = "Hola, ¿Cómo estás? Necesito ayuda para configurar el router"

    chat_message_history = ChatMessageHistory()
    chat_message_history.add_user_message(human_query)

    chat_open_ai = self._get_chat_openai()

    ai_message = chat_open_ai.invoke([HumanMessage(content=human_query)])

    chat_message_history.add_ai_message(ai_message.content)

    all_messages = chat_message_history.messages
    print(all_messages)

    return ai_message.content
```
![memory-chat-message-history](./images/debug-memory-chat-message-history.png)
#### memoria completa en buffer
```python
from langchain.memory import (
    ChatMessageHistory,
    ConversationBufferMemory,
)
import pickle # serializador

def ejemplo_buffer_en_memoria_completa(self) -> str:
    conversation_buffer_memory = ConversationBufferMemory()
    conversation_chain = ConversationChain(
        llm = self._get_chat_openai(),
        memory=conversation_buffer_memory,
        verbose=True
    )
    human_query = "Hola, necesito saber cómo usar mis datos históricos para crear un bot de preguntas y respuestas"
    conversation_chain.predict(input=human_query)

    human_query2 = "Necesito más detalle de cómo implementarlo"
    conversation_chain.predict(input=human_query2)

    print(conversation_buffer_memory.buffer) # string se muestra todo el dialogo

    # carga las variables de la memoria
    dic_memory_vars = conversation_buffer_memory.load_memory_variables({})

    # persistir el contenido de la memoria en un fichero en formato bin
    conv_buffer_memory = conversation_chain.memory
    # pickle (escabeche) es un serializador
    str_bin_pickle = pickle.dumps(conv_buffer_memory)
    path_mem_file = "./database/sk_learn/memory.pkl"
    with open(path_mem_file, "wb") as f: # wb: write binary
        f.write(str_bin_pickle)

    str_bin_pickle = open(path_mem_file, "rb").read()
    conv_buffer_memory = pickle.loads(str_bin_pickle)
    conversation_from_memory = ConversationChain(
        llm = self._get_chat_openai(),
        memory=conv_buffer_memory,
        verbose=True,
    )
    str_raw_conversation = conversation_from_memory.memory.buffer
    return str_raw_conversation
```
![debug buffer memory](./images/debug-buffer-memory.png)
![postman buffer memory](./images/postman-buffer-memory.png)
#### memoria en ventana
```python
from langchain.memory import (
    ConversationBufferWindowMemory
)
def ejemplo_buffer_en_memoria_con_ventana(self) -> str:
    #k indica el número de últimas iteraciones (pareja de mensajes human-AI) que guardara
    conversation_buffer_window_memory = ConversationBufferWindowMemory(k=1)
    conversation_chain = ConversationChain(
        llm=self._get_chat_openai(),
        memory=conversation_buffer_window_memory,
        verbose=True
    )
    human_query = "Hola, ¿Cómo estás?"
    conversation_chain.predict(input=human_query)

    human_query2 = "Necesito un consejo para tener un gran día"
    conversation_chain.predict(input=human_query2)

    str_raw_conversation = conversation_buffer_window_memory.buffer

    return str_raw_conversation
```
![window memory](./images/debug-window-memory.png)
![postman window memory](./images/postman-window-memory.png)

#### buffer de memoria resumido
```python
from langchain.memory import (
    ConversationSummaryBufferMemory
)
def ejemplo_buffer_en_memoria_resumido(self) -> str:
    chat_open_ai = self._get_chat_openai()

    conversation_buffer_summary_memory = ConversationSummaryBufferMemory(
        llm=chat_open_ai,
        max_token_limit=100
    )
    conversation_chain = ConversationChain(
        llm=chat_open_ai,
        memory=conversation_buffer_summary_memory,
        verbose=True
    )

    plan_viaje = '''
    Este fin de semana me voy de vacaciones a la playa, estaba pensando algo que fuera bastante relajado, pero necesito,
    un plan detallado por días con qué hacer en familia, extiendete todo lo que puedas
    '''
    conversation_chain.predict(input=plan_viaje)
    dic_messages = conversation_buffer_summary_memory.load_memory_variables({})

    str_summarized_conv = conversation_buffer_summary_memory.buffer

    return str_summarized_conv
```
![debug summary memory](./images/debug-summary-memory.png)
![postman summary memory](./images/postman-summary-memory.png)

### Agentes
- Un agente es una herramienta con capacidad de razonamiento y toma de decisiones para resolver un problema apoyandose en un grupo de herramientas que se le indica.
![agentes](./images/agents.png)
![what are agents](./images/what-are-agents.png)
- **ejemplo calculando total a partir de un texto**
```python
from langchain.agents import (
    load_tools, # https://python.langchain.com/api_reference/community/tools.html#module-langchain_community.tools
    initialize_agent,
    AgentType,
    create_react_agent,
    AgentExecutor
)
def ejemplo_agente_primer_caso_de_uso(self) -> str:
    chat_open_ai = self._get_chat_openai_no_creativity()

    # list of BaseTool. Definimos el pool de herramientas que utilizará el agente para realizar el caso de uso
    tools = load_tools(tool_names=["llm-math"], llm=chat_open_ai)
    # dir(AgentType) # todos los tipos de agentes que hay

    # se recomienda create_react_agent en lugar de initialize_agent
    agent_executor = initialize_agent(
        tools=tools,
        llm=chat_open_ai,
        agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION, # ZERO_SHOT significa que no estamos montando un modelo de pregunta respuesta
        verbose=True,
        handle_parsing_errors=True,
    )
    human_query = "Dime cuánto es 1598 multiplicado por 1983 y después sumas 1000"
    str_response = agent_executor.run(human_query)

    return f"{human_query}:\n{str_response}"
```
![debug agent](./images/debug-agent-text-calculator.png)
![debug agent vars](./images/debug-agent-text-calculator-vars.png)
![postman agent](./images/postman-agent-text-calculator.png)
- **ejemplo con create_react_agent**
```python
def ejemplo_agente_con_create_react_agent(self) -> str:
    template = '''
    Responde lo mejor que puedas usando tu conocimiento como LLM o bien las siguientes herramientas:
    {tools}
    Utiliza el siguiente formato:
    Pregunta: la pregunta de entrada que debes responder
    Pensamiento: siempre debes pensar en qué hacer
    Acción: la acción a realizar debe ser una de [{tool_names}]
    Entrada de acción: la entrada a la acción.
    Observación: el resultado de la acción.
    ... (este Pensamiento/Acción/Introducción de Acción/Observación puede repetirse N veces,si no consigues el resultado tras 5 intentos, para la jecución)
    Pensamiento: ahora sé la respuesta final
    Respuesta final: la respuesta final a la pregunta de entrada original
    ¡Comenzar! Recuerda que no siempre es necesario usar las herramientas
    Pregunta: {input}
    Pensamiento:{agent_scratchpad}        
    '''
    # agent_scratchpad.  El agente no llama a una herramienta solo una vez para obtener la respuesta deseada, sino que tiene una
    # estructura que llama a las herramientas repetidamente hasta obtener la respuesta deseada. Cada vez que llama a una herramienta,
    # en este campo se almacena cómo fue la llamada anterior, información sobre la llamada anterior y el resultado.
    chat_prompt_tpl = ChatPromptTemplate.from_template(template)

    chat_open_ai = self._get_chat_openai_no_creativity()
    tools = load_tools(tool_names=["llm-math"], llm=chat_open_ai)
    runnable = create_react_agent(
        tools=tools,
        llm=chat_open_ai,
        prompt=chat_prompt_tpl,
    )
    agent_executor = AgentExecutor(
        agent=runnable,
        tools=tools,
        verbose=True,
        return_intermediate_steps=True,
        handle_parsing_errors=True,
    )
    human_query = "Dime cuánto es 1598 multiplicado por 1983"
    dic_response = agent_executor.invoke({"input": human_query})

    return f"{dic_response.get("input")}:\n{dic_response.get("output")}"
```
![debug create-react-agent ia](./images/debug-ia-create-react-agent.png)
![debug create-react-agent vars](./images/debug-ia-create-react-agent-vars.png)
![postman create-react-agent](./images/postman-ia-create-react-agent.png)
![error create-react-agent](./images/error-ia-create-react-agent.png)
#### agente potenciado con motores de busqueda
- [Google Search API](https://serpapi.com/dashboard)
```python
# pip install google-search-results
# os.environ["SERPAPI_API_KEY"] = GOOGLE_SEARCH_API_KEY

def ejemplo_agente_con_google_search(self) -> str:
    chat_open_ai = self._get_chat_openai()
    tools = load_tools(tool_names=["serpapi", "llm-math"], llm=chat_open_ai)
    agent_executor = initialize_agent(
        tools=tools,
        llm=chat_open_ai,
        agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
    )
    human_request = "¿En qué año nació Einstein? ¿Cuál es el resultado de ese año multiplicado por 3?"
    dic_response = agent_executor.invoke(human_request)

    return f"{dic_response.get("input")}:\n{dic_response.get("output")}"
```
![agent google search api](./images/debug-ia-agent-with-google-search.png)
![agent google search api](./images/debug-agent-with-google-search-vars.png)
![postman agent google search api](./images/postman-agent-with-google-search.png)

#### agente programador de código
- **ejemplo ordenar lista**
```python
from langchain_experimental.agents.agent_toolkits import create_python_agent
from langchain_experimental.tools.python.tool import PythonREPLTool

def ejemplo_agente_programador_de_codigo_ordena_lista(self) -> str:
    chat_open_ai = self._get_chat_openai_no_creativity()

    agent_executor = create_python_agent(
        tool=PythonREPLTool(),
        llm=chat_open_ai,
        agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
    )
    lista_ejemplo = [3,1,5,3,5,6,7,3,5,10]

    human_query = f"Ordena la lista {lista_ejemplo}"
    str_response = agent_executor.run({"input": human_query})

    return f"{human_query}:\n{str_response}"
```
![postman programador codigo ordena lista](./images/postman-programador-codigo-ordena-lista.png)
- **ejemplo dataframe**
- Este codigo no esta del todo fino a veces funciona y otras da error.
- El eval no lo he podido ejecutar correctamente
```python
def ejemplo_agente_programador_de_codigo_con_dataframe(self) -> str:
    # una vez que se lee y se crea el df da error en la interpretacion quiza por algun separador.
    # mejor leerlo como xlsx. Para eso he tenido que abrirlo en excel y guardarlo con su extensión
    # path_xlsx = "./modules/lang_chain/application/lc_ask_question/curso/datos-ventas-small.csv"
    path_xlsx = "./modules/lang_chain/application/lc_ask_question/curso/datos-ventas-small.xlsx"
    df = pd.read_excel(path_xlsx) #tiene que llamarse df ya que la ia devuelve la sentencia con df.xxx
    # df = pd.read_csv(path_xlsx)
    # df.head() # muestra las primeras 5 filas

    chat_open_ai = self._get_chat_openai_no_creativity()
    agent_executor = create_python_agent(
        tool=PythonREPLTool(),
        llm=chat_open_ai,
        agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
    )

    human_query = f'''
    ¿Qué sentencias de código tendría que ejecutar para obtener la suma de venta total agregada por Línea de Producto? 
    Este sería el dataframe {df}, no tienes que ejecutar la sentencia, solo pasarme el código a ejecutar.
    '''
    # es raro. espera un diccionario pero si le paso uno da error. Con un string no lo da.
    ia_response = agent_executor.invoke(human_query)
    pandas_code = ia_response.get("output")
    if "df." in pandas_code:
        result = eval(pandas_code) # ejecuta la sentencia
        print(result)

    return f"{pandas_code}"
```
![debug-ia-agent-with-dataframe](./images/debug-ia-agent-with-dataframe.png)
![debug-ia-agent-with-dataframe-vars](./images/debug-agent-with-dataframe-vars.png)

#### creacion de herramientas personalizadas
![custom tools](./images/agent-custom-tools.png)
```python
def ejemplo_agente_herramientas_personalizadas(self) -> str:
    chat_open_ai = self._get_chat_openai_no_creativity()
    tools = load_tools(tool_names=["wikipedia", "llm-math"], llm=chat_open_ai)

    # debe llvar argumento sino lanza The error indicates that the ZeroShotAgent does not support tools that require multiple inputs.
    @tool
    def persona_amable(text: str = "") -> str:
        '''
        Retorna la persona más amable. Se espera que la entrada esté vacía ""
        y retorna la persona más amable del universo
        '''
        return "Miguel Celebres"

    #otras tools
    # nombre_api_interna(text: str = "") -> str:
    # hora_actual(text: str = "") -> str:

    tools.append(persona_amable)

    agent_executor = initialize_agent(
        tools=tools,
        llm=chat_open_ai,
        agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True
    )
    human_query = "¿Quién es la persona más amable del universo?"

    dic_response = agent_executor.invoke({"input": human_query})

    return f"{dic_response.get('input')}:\n{dic_response.get('output')}"
```
![debug agent custom tools](./images/debug-agent-custom-tools-vars.png)

#### agentes conversacionales con memoria
```python
def ejemplo_agente_conversacional_con_memoria(self) -> str:
    chat_open_ai = self._get_chat_openai_no_creativity()

    conversation_buffer_memory = ConversationBufferMemory(memory_key="chat_history")
    tools = load_tools(tool_names=["wikipedia"], llm=chat_open_ai)
    agent_executor = initialize_agent(
        tools=tools,
        llm=chat_open_ai,
        agent_type=AgentType.CONVERSATIONAL_REACT_DESCRIPTION,
        memory=conversation_buffer_memory,
        verbose=True,
    )
    human_query = "Dime 5 productos escenciales para el mantenimiento del vehiculo"
    agent_executor.invoke(human_query)

    human_query = "¿Cuál de los anteriores es el más importante?"
    agent_executor.invoke(human_query)

    human_query = "Necesito la respuesta anterior en castellano"
    dic_result = agent_executor.invoke(human_query)

    return f"{dic_result.get("input")}:\n{dic_result.get("output")}"
```
![debug agent with memory 0](./images/debug-ia-agent-with-memory-0.png)
![debug agent with memory 1](./images/debug-ia-agent-with-memory-1.png)
![debug agent with memory 2](./images/debug-ia-agent-with-memory-2.png)
![debug agent with memory vars](./images/debug-ia-agent-with-memory-vars.png)

#### agente RAG con chat
```python
def ejemplo_proyecto_rag(self) -> str:
    vectordb_spain = EjemplosSklearnRepository.get_instance().get_spain_db_connection()

    chat_open_ai = self._get_chat_openai_no_creativity()
    llm_chain_extractor = LLMChainExtractor.from_llm(llm=chat_open_ai)
    compression_retriever = ContextualCompressionRetriever(
        base_compressor = llm_chain_extractor,
        base_retriever = vectordb_spain.as_retriever()
    )

    @tool
    def consulta_interna(text: str = "") -> str:
        '''
        Retorna respuestas sobre la historia de España. Se espera que la entrada sea una cadena de texto
        y retorna una cadena con el resultado más relevante. Si la respuesta con esta herramienta es relevante,
        no debes usar ninguna herramienta más
        '''
        compressed_docs = compression_retriever.invoke(text)
        resultado = "No tengo respuesta"
        if (isinstance(compressed_docs, list) and len(compressed_docs) > 0):
            resultado = compressed_docs[0].page_content
        return resultado

    tools = load_tools(tool_names=["wikipedia"], llm=chat_open_ai)
    tools = tools + [consulta_interna]

    conversation_buffer_memory = ConversationBufferMemory(memory_key="chat_spain_history")
    agent_executor = initialize_agent(
        tools=tools,
        llm=chat_open_ai,
        agent_type=AgentType.CONVERSATIONAL_REACT_DESCRIPTION,
        memory=conversation_buffer_memory,
        verbose=True,
        handle_parsing_errors=True,
    )

    human_query = "¿Qué periodo abarca cronológicamente en España el siglo de oro?"
    agent_executor.invoke(human_query)

    human_query = "¿Qué pasó durante la misma etapa en Francia?"
    agent_executor.invoke(human_query)

    # pregunta que no podemos responder con nuestra BD Vectorial
    human_query = "¿Cuáles son las marcas de vehículos más famosas hoy en día?\")"
    dic_result = agent_executor.invoke(human_query)

    return f"{dic_result.get("input")}:\n{dic_result.get("output")}"
```
![debug-ia-rag-agent](./images/debug-ia-rag-agent.png)
![postman-ia-rag-agent-vars](./images/postman-ia-rag-agent.png)

#### agente sql
![sql agent](./images/sql-agent.png)
```python
```

