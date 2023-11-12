from flask import Blueprint, request, abort, jsonify
from api.db import get_db
import bcrypt
import re

authentication_bp = Blueprint('auth', __name__, url_prefix='/auth')

@authentication_bp.route('/login/', methods=['POST'])
def login():
    try:
        email = request.form['email'].lower()
        password = request.form['password'].encode('utf-8')

        if not check_email(email) and not check_password(password):
            raise TypeError
        
        db = get_db()
        student = db.execute("SELECT * FROM student WHERE email = ?", (email,)).fetchone()
        if student is None:
            abort(404)

        if bcrypt.checkpw(password, student['pass']):
            return jsonify({"message": "Login successful"}), 200
        else:
            abort(401)
    except TypeError:
        abort(406)
            

@authentication_bp.route('/register/', methods=['POST'])
def register():
    try:
        email = request.form["email"].lower()
        password = request.form["password"].encode('utf-8')
        name = request.form["name"].title()
        course = request.form["course"].upper()

        if not check_data(name, email, password, course):
            raise TypeError
        
        salt = bcrypt.gensalt()
        hashed_password = bcrypt.hashpw(password, salt)
        db = get_db()
        db.execute(
            "INSERT INTO student (student_name, email, pass, salt, course) VALUES (?, ?, ?, ?, ?)",(name, email, hashed_password, salt, course),
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

    return jsonify({"message": "User Created"})


@authentication_bp.app_errorhandler(404)
def bad_request(e):
    error = {
        "message": "User is not registered"
    }
    return jsonify(error), 404

@authentication_bp.app_errorhandler(401)
def bad_request(e):
    error = {
        "message": "Incorrect Password"
    }
    return jsonify(error), 401

@authentication_bp.app_errorhandler(412)
def bad_request(e):
    error = {
        "message": "Missing Form Data"
    }
    return jsonify(error), 412

@authentication_bp.app_errorhandler(406)
def bad_request(e):
    error = {
        "message": "Value/s are not appropriate"
    }
    return jsonify(error), 406

@authentication_bp.app_errorhandler(409)
def bad_request(e):
    error = {
        "message": "Integrity Error Database, User Already Exists"
    }
    return jsonify(error), 409

def check_email(email):
    if email is None:
        raise TypeError
    
    if not re.findall('^[a-z]+.[0-9]{6}@sggscc.ac.in$', email):
        return False
    
    return True

def check_password(password):
    if password is None:
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

    if course is None:
        raise TypeError
    
    if course not in courses:
        return False
    return True


def check_data(name, email, password, course):
    if name is None:
        raise TypeError
    elif check_course(course) and check_password(password) and check_email(email):
        return True
    else:
        return False