import requests

inputs = [
    {
        "path": "confessions",
        "method": "GET",
        "desc": "Get Confessions",
        "inputs": [
            {
                "header": {
                    "email": "uday.224026@sggscc.ac.in"
                },
                "status_code": 200,
                "message": 'Confessions found!',
                "help": "Proper Request"
            },
            {
                "header": {
                    "email": ""
                },
                "status_code": 400,
                "message": 'Email is missing',
                "help": "Empty email",
            },
            {   
                "header": {},
                "status_code": 400,
                "message": 'Email is missing',
                "help": "No email",
            },
            {
                "header": {
                    "email": "itsudayy@gmail.com"
                },
                "status_code": 400,
                "message": "Email is not registered",
                "help": "Not registered email"
            }
        ]
    },
    {   
        "path": "confession",
        "method": "POST",
        "desc": "POST Confession",
        "inputs": [
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
    },
    {
        "path": "create_user",
        "method": "POST",
        "desc": "Create User",
        "inputs": [
            {
                "data": {
                    "name": "Harshit Agrawal",
                    "email": "harshit.224044@sggscc.ac.in",
                    "password": "uday1601",
                    "course": "BSC"
                },
                "status_code": 200,
                "message": "User Created",
                "help": "Proper request"
            },
            {
                "data": {
                    "name": "Uday Sharma",
                    "email": "uday.224026@sggscc.ac.in",
                    "password": "uday1601",
                    "course": "BSC"
                },
                "status_code": 400,
                "message": "Email is already registered",
                "help": "Email is already registered"
            },
            {
                "data": {
                    "name": "Aishwarya Jajoo",
                    "email": "aishwarya.224014@sggscc.ac.in",
                    "password": "",
                    "course": "BSC"
                },
                "status_code": 400,
                "message": "Data is missing",
                "help": "Password is empty"
            },
            {
                "data": {
                    "name": "Aishwarya Jajoo",
                    "email": "",
                    "password": "uday1601",
                    "course": "BSC"
                },
                "status_code": 400,
                "message": "Data is missing",
                "help": "Email is empty"
            },
            {
                "data": {
                    "name": "Aishwarya Jajoo",
                    "email": "aishwarya.224014@sggscc.ac.in",
                    "password": "uday1601",
                    "course": ""
                },
                "status_code": 400,
                "message": "Data is missing",
                "help": "Body is empty"
            },
            {
                "data": {
                    "name": "",
                    "email": "aishwarya.224014@sggscc.ac.in",
                    "password": "uday1601",
                    "course": "BSC"
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
    },
]

def check():
    for test_case in inputs:
        print(f"\n\n{test_case.get("method")} {test_case.get("path")}")

        for item in test_case.get("inputs"):
            if test_case.get("method") == "GET":
                res = requests.get(f"http://127.0.0.1:5000/{test_case.get("path")}", headers=item["header"])
            else:
                res = requests.post(f"http://127.0.0.1:5000/{test_case.get("path")}", json=item["data"])
            print('🔍', item.get('help'))
            if res.status_code != item["status_code"]:
                print(f"❌ {test_case.get("method")} /{test_case.get("path")} not working properly")
                print(f"Server Status Code: {res.status_code}")
                print(f"Expected Status Code: {item["status_code"]}")
                return False

            data = res.json()
            if data['message'] != item["message"]:
                print(f"❌ {test_case.get("method")} /{test_case.get("path")} not working properly")
                print(f"Server Message: {data['message']}")
                print(f"Expected Message: {item["message"]}")
                return False
        
        print(f"✅ {test_case.get("method")} /{test_case.get("path")} working properly")

check()