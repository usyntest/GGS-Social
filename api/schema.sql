DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS confession;

CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    student_name TEXT NOT NULL,
    course TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    pass TEXT NOT NULL,
    salt TEXT NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE confession (
    confession_id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    body TEXT NOT NULL,
    student_id INTEGER NOT NULL,
    FOREIGN KEY(student_id) REFERENCES student(student_id)
);