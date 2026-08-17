/** Codigos HTTP que devuelve la API. Gemelo de `response_code_enum.py`. */
export const ResponseCodeEnum = {
    OK: 200,
    CREATED: 201,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    NOT_FOUND: 404,
    CONFLICT: 409,
    INTERNAL_SERVER_ERROR: 500,
} as const;
