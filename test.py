import requests

def get_confessions():
    inputs = [
        {
            "header": {
                "email": "uday.224026@sggscc.ac.in"
            },
            "status_code": 200,
            "message": 'Confessions found!'
        },
        {
            "header": {
                "email": ""
            },
            "status_code": 400,
            "message": 'Email is missing'
        },
        {   
            "header": {},
            "status_code": 400,
            "message": 'Email is missing',
        },
        {
            "header": {
                "email": "itsudayy@gmail.com"
            },
            "status_code": 400,
            "message": "Email is not registered"
        }
    ]

    print("\n\nGET /confessions")

    for item in inputs:
        res = requests.get("http://127.0.0.1:5000/confessions", headers=item["header"])
        print('🔍 Email - ', item["header"].get('email', ""))
        if res.status_code != item["status_code"]:
            print("❌ GET /confessions not working properly")
            return False

        data = res.json()
        if data['message'] != item["message"]:
            print("❌ GET /confessions not working properly")
            return False
    
    print("✅ GET /confessions working properly")

def post_confession():
    inputs = [
        {
            "data": {
                "user_id": 1,
                "email": "uday.224026@sggscc.ac.in",
                "password": "uday1601",
                "body": "hello world, im uday and this is me testing my api."
            },
            "status_code": 200,
            "message": "Confession Posted",
            "help": "Proper request"
        },
        {
            "data": {
                "user_id": 1,
                "email": "itsudayy@gmail.com",
                "password": "uday1601",
                "body": "hello world, im uday and this is me testing my api."
            },
            "status_code": 400,
            "message": "Email is not registered",
            "help": "Email is not registered"
        },
        {
            "data": {
                "user_id": 1,
                "email": "uday.224026@sggscc.ac.in",
                "password": "",
                "body": "hello world, im uday and this is me testing my api."
            },
            "status_code": 400,
            "message": "Data is missing",
            "help": "Password is empty"
        },
        {
            "data": {
                "user_id": 1,
                "email": "",
                "password": "uday1601",
                "body": "hello world, im uday and this is me testing my api."
            },
            "status_code": 400,
            "message": "Data is missing",
            "help": "Email is empty"
        },
        {
            "data": {
                "user_id": 0,
                "email": "uday.224026@sggscc.ac.in",
                "password": "uday1601",
                "body": "hello world, im uday and this is me testing my api."
            },
            "status_code": 400,
            "message": "Email is not registered",
            "help": "user_id will not match email"
        },
        {
            "data": {
                "user_id": 1,
                "email": "uday.224026@sggscc.ac.in",
                "password": "uday1601",
                "body": ""
            },
            "status_code": 400,
            "message": "Data is missing",
            "help": "Body is empty"
        },
        {   
            "data": {},
            "status_code": 400,
            "message": "Invalid JSON data",
            "help": "Empty data object"
        }
    ]

    print("\n\nPOST /confession")

    for item in inputs:
        res = requests.post("http://127.0.0.1:5000/confession", json=item["data"])
        print('🔍', item.get('help'))
        if res.status_code != item["status_code"]:
            print("here1")
            print("❌ POST /confession not working properly")
            return False

        data = res.json()
        if data['message'] != item["message"]:
            print('here2')
            print("❌ POST /confession not working properly")
            return False
    
    print("✅ POST /confessions working properly")

    
    
get_confessions()
post_confession()