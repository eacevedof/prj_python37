### code
- https://github.com/eacevedof/prj_python37/tree/master/wa-chatgpt/be-api/modules/lang_chain/application/lc_ask_question

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
              "response": generated_texts[0][0].text,
          },
      }
```
- respuesta:
- ![lc-chat-generate-result](./images/lc-chat-generate-result.png)