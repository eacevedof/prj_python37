from vue.infra.redis.application.redis_put_service import put_random_values


def __invoke() -> None:
    put_random_values()


__invoke()
