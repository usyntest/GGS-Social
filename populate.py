import sqlite3

db = sqlite3.connect('ggs-social.db')

users = [
    {
        "name": "Uday Sharma",
        "email": "uday.224026@sggscc.ac.in",
        "password": "uday1601",
        "course": "BSC",
    },
    {
        "name": "Priyanshi Ahuja",
        "email": "priyanshi.224044@sggscc.ac.in",
        "password": "priyanshi2503",
        "course": "BSC",
    },
    {
        "name": "Aishwarya Jajoo",
        "email": "aishwarya.224014@sggscc.ac.in",
        "password": "uday1601",
        "course": "BSC",
    },
    {
        "name": "Priyanshi Makkar",
        "email": "priyanshi.224016@sggscc.ac.in",
        "password": "uday1601",
        "course": "BSC",
    }
]

confessions = [
    {
        "user_id": 0,
        "body": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?"
    },
    {
        "user_id": 0,
        "body": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?"
    },
    {
        "user_id": 3,
        "body": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?"
    },
    {
        "user_id": 2,
        "body": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?"
    }
]

cur = db.cursor()

for item in users:
    cur.execute("INSERT INTO user (name, email, password, course) VALUES (?, ?, ?, ?);", (item["name"], item["email"], item["password"], item["course"]))

for item in confessions:
    cur.execute("INSERT INTO confession (user_id, body) VALUES (?, ?);", (item["user_id"], item["body"]))

res = cur.execute("SELECT * FROM user;").fetchall()
print(res)
res = cur.execute("SELECT * FROM confession;").fetchall()
print(res)

db.commit()