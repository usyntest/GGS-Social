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

    cur.execute("CREATE TABLE IF NOT EXISTS user (user_id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE, course TEXT, password TEXT);")

    cur.execute("CREATE TABLE IF NOT EXISTS confession(post_id INTEGER PRIMARY_KEY, user_id INTEGER, body TEXT, created DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES user(user_id));")


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

    if not user_exists(data.get("email", ''), data.get('user_id')):
        return {"message": "Email is not registered"}, 400

    db = sqlite3.connect(database)
    cur = db.cursor()
    cur.execute("INSERT INTO confession (user_id, body) VALUES (?, ?);", (data["user_id"], data["body"]))
    db.commit()
    
    return {"message": "Confession Posted"}, 200
