import { createPinia } from "pinia";
import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router";

import App from "@/App.vue";
import { Routes } from "@/core/routes/Routes";
import "@/style.css";

/**
 * Arranque del front. Gemelo de `public/main.py`.
 *
 * Igual que alli, este fichero solo CABLEA: crea la aplicacion, le enchufa el
 * enrutador y el almacen de estado, y la monta. No hay logica aqui.
 */
const router = createRouter({
    history: createWebHistory(),
    routes: Routes,
});

createApp(App).use(createPinia()).use(router).mount("#app");
