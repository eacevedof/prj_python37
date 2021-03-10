from pprint import pprint


def fn_b(event, context):
    pprint(event)
    pprint(context)
    return (
        "Hello im function B",
    )
