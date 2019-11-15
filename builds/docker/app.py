from flask import Flask

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    return "Hello!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000)  # pragma: no cover