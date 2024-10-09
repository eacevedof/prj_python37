from flask import render_template_string

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

<h2>1. xxxx:</h2>
<code>
	/api/xxx
</code>
<pre>
curl --location 'https://xxxx.com' \
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
    return render_template_string(html)