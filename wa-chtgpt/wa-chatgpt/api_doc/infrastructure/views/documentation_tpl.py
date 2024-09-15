

def render() -> str:
    html = """
<!DOCTYPE html>
<html lang="{{ str_replace("_", "-", app()->getLocale()) }}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Lazarus Freshdesk API</title>
</head>
<body class="font-sans antialiased dark:bg-black dark:text-white/50">
<h1>Lazarus Freshdesk API</h1>

<h2>1. Tickets:</h2>
<code>
	/api/tickets
</code>
<pre>
curl --location 'https://freshdesk-api.lazarus.es/api/tickets/?start_date=2024-01-01&end_date=2024-10-01' \
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