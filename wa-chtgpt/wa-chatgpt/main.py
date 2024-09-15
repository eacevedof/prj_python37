from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/get-data', methods=['GET'])
def get_data():
    # Retrieve query parameters
    param1 = request.args.get('param1')
    param2 = request.args.get('param2')

    # Process the parameters and create a response
    response = {
        'param1': param1,
        'param2': param2,
        'message': 'GET request received successfully!'
    }

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)