# GGS Social

Social Media app for the students of [SGGSCC](https://www.sggscc.ac.in/) (my college)

This project is the successor of my failed [Zuckerberg moment](https://github.com/usyntest/CollegeApp). It lacked a few features, the first and the biggest being a web app, mobile apps are easier to use.

## Technologies Used:

- Flutter
- Flask

## Running the Development Environment

Create the virtual environment and install dependencies

```
cd api
virtualenv venv
source venv/Scripts/activate #windows
source venv/bin/activate #linux
pip install -r requirements.txt
```

Initialize the database

```
flask --app api init-db
```

Start the development server

```
flask --app api run --debug
```

## Database Schemes

### Student

- Student_ID (Primary Key)
- Student_Name
- Email
- Course
- Pass
- Created

### Confession

- Confession_ID (Primary Key)
- Body
- Created
- Student_ID (Foreign Key)

## API Routes

### Authentication

`/auth/register/` - Registering a user

```json
{
    "name": "uday",
    "email": only emails with @sggscc.ac.in domain
    "course": ['BCH', 'BCP', 'BSC', 'BMS', 'BAE', 'BBE', 'BPA'],
    "password": str (8 <= length <= 16)
}
```

`/auth/login/` - Login

```json
{
    "name": "uday",
    "email": only emails with @sggscc.ac.in domain
}
```

- `404` - User is not registered (login)
- `401` - Incorrect password (login)
- `412` - Request is incomplete. Forget to give few parameters. Key error while retrieving body elements
- `406` - Data checks are not passed. Invalid data for User creation
- `409` - User already exists, Integrity Error Database(register)

### Confession

`/confession/get?apiKey=?` - Get last 25 confessions  
- Response
```json
{
    "message": "confession list sent",
    "confessions": [
        {"body": "Hello, World. This is dummy text"},
        {"body": "Hello, World. This is dummy text"},
        {"body": "Hello, World. This is dummy text"},
        {"body": "Hello, World. This is dummy text"},
    ]
}
```
`/confession/post/` - Post a confession
- Request (JSON Body)
```json
{
    "apiKey": apiKey
}
```

- Response 
```json
{
    "message": "confession created",
    "confessions": [
        {"body": "Hello, World. This is dummy text"},
        {"body": "Hello, World. This is dummy text"},
        {"body": "Hello, World. This is dummy text"},
        {"body": "Hello, World. This is dummy text"},
    ]
}
```
- `401` - Either the apiKey missing or it is wrong
- `500` - Internal Server Error

## Notes for Myself
