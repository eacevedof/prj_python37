from flask import render_template_string

def render() -> str:
    html = """
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>API Pyspark</title>
</head>
<body>
<h1>API Pyspark</h1>

</body>
</html>
    """
    return render_template_string(html)