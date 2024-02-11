from flask import Flask, request, jsonify
import sqlite3
import os

database = 'ggs-social.db'


def create_db():
    if os.path.exists(database):
        print("Database already exists.")
        return False

    con = sqlite3.connect(database)
    cur = con.cursor()

    cur.execute(
        "CREATE TABLE IF NOT EXISTS user (user_id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE, course TEXT, password TEXT);")

    cur.execute(
        "CREATE TABLE IF NOT EXISTS confession(post_id INTEGER PRIMARY_KEY, user_id INTEGER, body TEXT, created DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES user(user_id));")


def user_exists(email, user_id=None):
    db = sqlite3.connect(database)
    res = db.execute('SELECT * FROM user WHERE email = ?;', (email,)).fetchone()

    if res is None:
        return False

    if user_id is not None and user_id != res[0]:
        return False

    return True


app = Flask(__name__)
create_db()


@app.route('/', methods=['GET'])
def check():
    return {"message": "working"}


@app.route('/confessions', methods=['GET'])
def get_confessions():
    email = request.headers.get('email', '')

    response = {
        "confessions": [],
        "message": ""
    }

    if email == '':
        response["message"] = "Email is missing"
        return response, 400

    if not user_exists(email):
        response["message"] = "Email is not registered"
        return response, 400

    db = sqlite3.connect(database)
    confessions = db.execute('SELECT * FROM confession ORDER BY created DESC LIMIT 25').fetchall()

    if confessions is None:
        response["message"] = "No confessions yet."
        return response, 200

    response["confessions"] = confessions
    response["message"] = "Confessions found!"

    return response


@app.route('/confession', methods=['POST'])
def post_confession():
    data = request.get_json()

    if len(data) == 0:
        return {"message": "Invalid JSON data"}, 400

    for key in ['body', 'email', 'password']:
        if data.get(key, '') == "":
            return {"message": "Data is missing"}, 400

    if not user_exists(data.get("email", ''), data.get('userID')):
        return {"message": "Email is not registered"}, 400

    db = sqlite3.connect(database)
    cur = db.cursor()
    cur.execute("INSERT INTO confession (user_id, body) VALUES (?, ?);", (data["userID"], data["body"]))
    db.commit()

    return {"message": "Confession Posted"}, 200


@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    if len(data) == 0:
        return {"message": "Invalid JSON data"}, 400

    for key in ['name', 'email', 'password', 'course']:
        if data.get(key, '') == "":
            return {"message": "Data is missing"}, 400

    if user_exists(data.get('email', '')):
        return {"message": "Email is already registered"}, 400

    db = sqlite3.connect(database)
    cur = db.cursor()
    cur.execute("INSERT INTO user (name, email, password, course) VALUES (?, ?, ?, ?)",
                (data.get('name'), data.get('email'), data.get('password'), data.get('course')))
    db.commit()

    return {"message": "User Created"}, 200


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    if len(data) == 0:
        return {"message": "Invalid JSON data"}, 400

    for key in ['email', 'password']:
        if data.get(key, '') == "":
            return {"message": "Data is missing"}, 400

    if not user_exists(data.get('email', '')):
        return {"message": "Email is not registered"}, 400

    db = sqlite3.connect(database)
    res = db.execute('SELECT * FROM user WHERE email = ?;', (data.get('email'),)).fetchone()

    if data.get('password') != res[4]:
        return {"message": "Password is incorrect"}, 400

    user = {"userID": res[0], "name": res[1], "email": res[2], "course": res[3], "password": res[4]}

    return {"message": "Logged In Successfully", "user": user}, 200
