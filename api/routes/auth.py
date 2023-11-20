from flask import Blueprint, request, abort, jsonify
from api.db import get_db
import bcrypt
import re

authentication_bp = Blueprint('auth', __name__, url_prefix='/auth')

@authentication_bp.route('/login/', methods=['POST'])
def login():
    try:
        data = request.get_json()
        email = data.get('email', '').lower()
        password = data.get('password', '').encode('utf-8')
        if not check_email(email) and not check_password(password):
            raise TypeError
        
        db = get_db()
        student = db.execute("SELECT * FROM student WHERE email = ?", (email,)).fetchone()
        if student is None:
            abort(404)
        if bcrypt.checkpw(password, student['pass']):
            return jsonify({"message": "Login successful", "name": student['student_name'], "email": student['email'], "course": student["course"], "apiKey": student["api_key"].decode('UTF-8')}), 200
        else:
            abort(401)
    except KeyError:
        # Raised when the form data is missing data
        abort(412)
    except TypeError as e:
        print(e)
        abort(406)
            

@authentication_bp.route('/register/', methods=['POST'])
def register():
    try:
        data = request.get_json()

        email = data.get("email", '').lower()
        password = data.get("password", '').encode('utf-8')
        name = data.get("name", '').title()
        course = data.get("course", '').upper()

        if not check_data(name, email, password, course):
            raise TypeError
        
        salt = bcrypt.gensalt()
        api_key = bcrypt.hashpw(password, bcrypt.gensalt())
        hashed_password = bcrypt.hashpw(password, salt)
        db = get_db()
        db.execute(
            "INSERT INTO student (student_name, email, pass, salt, course, api_key) VALUES (?, ?, ?, ?, ?, ?)",(name, email, hashed_password, salt, course, api_key),
        )
        db.commit()
    except KeyError:
        # Raised when the form data is missing data
        abort(412)
    except TypeError:
        # Raised when either of the 4 values is None
        abort(406)
    except db.IntegrityError:
        abort(409)

    return jsonify({"message": "User Created", "name": name, "email": email, "course": course, "apiKey": api_key.decode('UTF-8')})


@authentication_bp.app_errorhandler(404)
@authentication_bp.app_errorhandler(401)
@authentication_bp.app_errorhandler(412)
@authentication_bp.app_errorhandler(406)
@authentication_bp.app_errorhandler(409)
def bad_request(e):
    error_messages = {
        404: "User is not registered",
        401: "Incorrect Password",
        412: "Missing Form Data",
        406: "Value/s are not appropriate",
        409: "Integrity Error Database, User Already Exists"
    }

    status_code = getattr(e, 'code', 500)  # Default to 500 if code attribute not present
    error = {"error": error_messages.get(status_code, "Internal Server Error")}
    return jsonify(error), status_code


def check_email(email):
    if not email:
        raise TypeError
    
    if not re.findall('^[a-z]+.[0-9]{6}@sggscc.ac.in$', email):
        return False
    
    return True

def check_password(password):
    if not password:
        raise TypeError
    if len(password) < 8 or len(password) > 16:
        return False
    
    return True

def check_course(course):
    courses = [
        'BCH',
        'BCP',
        'BSC',
        'BMS',
        'BAE',
        'BBE',
        'BPA'
    ]

    if not course:
        raise TypeError
    
    if course not in courses:
        return False
    return True


def check_data(name, email, password, course):
    if not name:
        raise TypeError
    elif check_course(course) and check_password(password) and check_email(email):
        return True
    else:
        return False