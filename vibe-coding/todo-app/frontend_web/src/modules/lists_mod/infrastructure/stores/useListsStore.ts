import { defineStore } from "pinia";

import { CreateListDto } from "@/modules/lists_mod/application/create_list/CreateListDto";
import { CreateListService } from "@/modules/lists_mod/application/create_list/CreateListService";
import { DeleteListDto } from "@/modules/lists_mod/application/delete_list/DeleteListDto";
import { DeleteListService } from "@/modules/lists_mod/application/delete_list/DeleteListService";
import { SearchListsDto } from "@/modules/lists_mod/application/search_lists/SearchListsDto";
import { SearchListsService } from "@/modules/lists_mod/application/search_lists/SearchListsService";
import type { ListEntity } from "@/modules/lists_mod/domain/entities/ListEntity";
import { HttpException } from "@/modules/shared/domain/exceptions/HttpException";

/**
 * EL STORE ES AL FRONT LO QUE EL CONTROLLER ES AL BACKEND.
 * ========================================================
 *
 * Si solo lees un fichero del front, que sea este.
 *
 * Un store de Pinia es INFRAESTRUCTURA, y por eso vive en
 * `<modulo>/infrastructure/stores/`. Dos razones:
 *   - es un artefacto de un framework concreto (`defineStore` viene de Pinia)
 *   - lo que guarda es estado de INTERFAZ: si esta cargando, el ultimo error, la
 *     coleccion que se esta mostrando. Nada de eso son reglas de negocio.
 *
 * QUE PUEDE HACER                          QUE NO PUEDE HACER
 * ---------------                          ------------------
 * Llamar a un Service                      Llamar a `fetch` o a un *ApiRepository
 * Guardar el resultado en su estado        Contener reglas de negocio
 * CAPTURAR la excepcion -> estado de UI    Ser importado por un Service o el dominio
 * Ser importado por las vistas `.vue`      Importar el store de otro modulo
 *
 * **ES EL UNICO SITIO DEL FRONT CON try/catch**, exactamente igual que el
 * controller lo es en el backend. Las vistas `.vue` solo LEEN `error` e
 * `isLoading`; no capturan nada.
 *
 * Si te ves poniendo un try/catch en una vista, la respuesta casi siempre es que
 * falta una accion en el store.
 */
export const useListsStore = defineStore("lists", {
    state: () => ({
        lists: [] as ListEntity[],
        isLoading: false,
        error: "",
    }),

    actions: {
        async searchLists(nameContains = ""): Promise<void> {
            this.isLoading = true;
            this.error = "";
            try {
                const result = await SearchListsService.getInstance().invoke(
                    SearchListsDto.fromPrimitives({ nameContains }),
                );
                this.lists = result.items;
            } catch (exception: unknown) {
                this.error = HttpException.getMessage(exception);
            } finally {
                // `finally` y no al final del `try`: si algo falla, la interfaz no
                // puede quedarse girando para siempre.
                this.isLoading = false;
            }
        },

        async createList(name: string, color: string | null): Promise<boolean> {
            this.error = "";
            try {
                await CreateListService.getInstance().invoke(CreateListDto.fromPrimitives({ name, color }));
                // Se vuelve a pedir el listado en vez de anadir el elemento a mano:
                // asi la pantalla muestra lo que hay en el servidor y no una copia
                // que puede haberse quedado vieja.
                await this.searchLists();
                return true;
            } catch (exception: unknown) {
                this.error = HttpException.getMessage(exception);
                return false;
            }
        },

        async deleteList(listId: number): Promise<boolean> {
            this.error = "";
            try {
                await DeleteListService.getInstance().invoke(DeleteListDto.fromPrimitives({ listId }));
                await this.searchLists();
                return true;
            } catch (exception: unknown) {
                // Aqui es donde se ve el 409 de "la lista tiene tareas sin
                // terminar": el mensaje que escribio el caso de uso del backend
                // llega tal cual a la pantalla.
                this.error = HttpException.getMessage(exception);
                return false;
            }
        },
    },
});
