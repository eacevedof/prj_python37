

def render() -> str:
    html = """
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>API documentation</title>
</head>
<body>
<h1>API Documentation</h1>

<h2>1. Tickets:</h2>
<code>
	/api/tickets
</code>
<pre>
curl --location 'https://hola.com' \
	--header 'Authorization: table-clients-token'
</pre>
<h3>Response</h3>
<pre>
{
    "status": 200,
    "results": {
        "total_counts": [],
        "total": 0
    }
}
</pre>
</body>
</html>
    """
    return html