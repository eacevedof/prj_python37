/** Metodos HTTP que usa el front. */
export const HttpMethodEnum = {
    GET: "GET",
    POST: "POST",
    PUT: "PUT",
    PATCH: "PATCH",
    DELETE: "DELETE",
} as const;

export type HttpMethod = (typeof HttpMethodEnum)[keyof typeof HttpMethodEnum];
