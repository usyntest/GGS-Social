from flask import Flask
from flask import request, jsonify, abort

app = Flask(__name__)

@app.route("/")
def root():
    return "<h1>Hello, World</h1>"


@app.post("/login/")
def login():
    pass


@app.post("/register/")
def register():
    try:
        username = request.form["email"]
        password = request.form["password"]
        name = request.form["name"]
    except KeyError:
        abort(400)
    return {"email": request.form["email"], "password": request.form["password"]}


@app.errorhandler(400)
def bad_request(error):
    response = jsonify({'error': 'Bad Request', 'message': 'Incomplete or incorrect registration details'})
    response.status_code = 400
    return response
