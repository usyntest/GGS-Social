DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS confession;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS welcome_message;
DROP TABLE IF EXISTS tag;

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email VARCHAR(255) UNIQUE,
    course TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE confession(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    tag INTEGER,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE post (
    id INTEGER PRIMARY KEY AUTOINCREMENT ,
    upvotes INT DEFAULT 0,
    user_id INT NOT NULL,
    body TEXT NOT NULL,
    photo_url VARCHAR(255) DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE welcome_message (
    id INTEGER PRIMARY KEY AUTOINCREMENT ,
    user_id INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(id)
);


INSERT INTO user (name, email, course, password)
VALUES
    ('Uday Sharma', 'uday.224026@sggscc.ac.in', 'BSC', 'uday1601'),
    ('Priyanshi Makkar', 'priyanshi.224016@sggscc.ac.in', 'BSC', 'priyanshi'),
    ('Aishwarya Jajoo', 'aishwarya.224014@sggscc.ac.in', 'BSC', 'aishwarya');

INSERT INTO confession (user_id, body, tag) VALUES
  (1, 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?', 3),
  (1, 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?', 2),
  (2, 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?', 1),
  (3, 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?', 1);

INSERT INTO post (upvotes, user_id, photo_url, body)
VALUES
    (0, 1, 'https://images.pexels.com/photos/20187061/pexels-photo-20187061/free-photo-of-women-in-the-village-grow-rice-together-for-the-family.jpeg', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?'),
    (0, 1, 'https://images.pexels.com/photos/10742392/pexels-photo-10742392.jpeg', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?'),
    (0, 2, 'https://images.pexels.com/photos/20200109/pexels-photo-20200109/free-photo-of-lake-entrance-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?'),
    (0, 3, 'https://images.pexels.com/photos/20150844/pexels-photo-20150844/free-photo-of-buddhist-temple-sakura-tree-nara-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?');