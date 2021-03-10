from pprint import pprint

def fn_a(event, context):
    pprint(event)
    pprint(context)
    return (
                "Hello im function A",
    )
