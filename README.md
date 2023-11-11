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

Start the development server
```
flask --app main run --debug
```