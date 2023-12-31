import os
from flask import Flask

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'api.sqlite')
    )

    # if test_config is None:
    #     app.config.from_file('config.py')
    # else:
    #     app.config.from_mapping(test_config)

    app.config.from_mapping(test_config)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    @app.route('/')
    def home():
        return {"Hello": "World"}

    from . import db
    db.init_app(app)

    from .routes import auth, confession
    app.register_blueprint(auth.authentication_bp)
    app.register_blueprint(confession.confession_bp)

    return app
