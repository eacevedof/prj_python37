/// <reference types="vite/client" />

// Tipado de las variables de entorno del front. Sin esto, `import.meta.env.X`
// seria `any` y el TypeScript estricto no serviria de nada justo en el borde por
// donde entra la configuracion.
interface ImportMetaEnv {
    readonly VITE_APP_API_BASE_URL: string;
    readonly VITE_APP_API_KEY: string;
}

interface ImportMeta {
    readonly env: ImportMetaEnv;
}
