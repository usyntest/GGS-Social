from flask import Blueprint, request, abort, jsonify
from api.db import get_db
import bcrypt

confession_bp = Blueprint('confession', __name__, url_prefix='/confession')

@confession_bp.route('/get/', methods=['GET'])
def get_confessions():
    try:
        # api_key = request.args.get('apiKey', '').encode('utf-8')
        api_key = request.headers.get('x-api-key', '').encode('utf-8')

        if api_key == "":
            return jsonify({"error": "API key is missing"}), 401
        
        db = get_db()

        student = db.execute(
            "SELECT * FROM student WHERE api_key = ?", (api_key,)
        ).fetchone()

        if student is None:
            return jsonify({"error": "Invalid API key"}), 401
        
        confessions = db.execute("SELECT * FROM confession ORDER BY confession_id DESC LIMIT 25").fetchall()

        confession_list = [{"body": confession["body"]} for confession in confessions]

        return jsonify({"message": "confession list sent", "confessions": confession_list}), 200

    except Exception as e:
        return jsonify({"error": e}), 500
    

@confession_bp.route('/post/', methods=['POST'])
def post_confessions():
    try:
        data = request.get_json()
        api_key = data.get("apiKey", "").encode('utf-8')
        body = data.get("body", "")

        if api_key == "":
            return jsonify({"error": "API key is missing"}), 401

        db = get_db()

        student = db.execute(
            "SELECT * FROM student WHERE api_key = ?", (api_key,)
        ).fetchone()

        if student is None:
            return jsonify({"error": "Invalid API key"}), 401
        
        confessions = db.execute("INSERT INTO confession (body, student_id) VALUES (?, ?)", (body, student["student_id"]))
        db.commit()

        confessions = db.execute("SELECT * FROM confession ORDER BY confession_id DESC LIMIT 25").fetchall()

        confession_list = [{"body": confession["body"]} for confession in confessions]

        return jsonify({"message": "confession created", "confessions": confession_list}), 200

    except Exception as e:
        return jsonify({"error": e}), 500

        