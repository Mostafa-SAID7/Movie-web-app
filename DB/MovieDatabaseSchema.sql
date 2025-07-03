
USE MovieDB;
GO

--1-create tables

--actor table
CREATE TABLE actor (
    act_id INT PRIMARY KEY,
    act_fname VARCHAR(20),
    act_lname VARCHAR(20),
    act_gender CHAR(1)
);

--director Table
CREATE TABLE director (
    dir_id INT PRIMARY KEY,
    dir_fname VARCHAR(20),
    dir_lname VARCHAR(20)
);

--movie Table
CREATE TABLE movie (
    mov_id INT PRIMARY KEY,
    mov_title VARCHAR(50),
    mov_year INT,
    mov_time INT,
    mov_lang VARCHAR(50),
    mov_dt_rel DATE,
    mov_rel_country CHAR(5)
);

--reviewer Table
CREATE TABLE reviewer (
    rev_id INT PRIMARY KEY,
    rev_name VARCHAR(30)
);

--genres Table
CREATE TABLE genres (
    gen_id INT PRIMARY KEY,
    gen_title VARCHAR(20)
);

--2-Relationship Tables
--rating Table
CREATE TABLE rating (
    mov_id INT,
    rev_id INT,
    rev_stars INT,
    num_o_ratings INT,
    PRIMARY KEY (mov_id, rev_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
    FOREIGN KEY (rev_id) REFERENCES reviewer(rev_id)
);

--movie_genres Table
CREATE TABLE movie_genres (
    mov_id INT,
    gen_id INT,
    PRIMARY KEY (mov_id, gen_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
    FOREIGN KEY (gen_id) REFERENCES genres(gen_id)
);

--movie_cast Table
CREATE TABLE movie_cast (
    act_id INT,
    mov_id INT,
    role VARCHAR(30),
    PRIMARY KEY (act_id, mov_id),
    FOREIGN KEY (act_id) REFERENCES actor(act_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
);

--movie_direction Table
CREATE TABLE movie_direction (
    dir_id INT,
    mov_id INT,
    PRIMARY KEY (dir_id, mov_id),
    FOREIGN KEY (dir_id) REFERENCES director(dir_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
);


--4-Insert Sample Data
--Insert Actors
INSERT INTO actor (act_id, act_fname, act_lname, act_gender)
VALUES 
(1, 'Leonardo', 'DiCaprio', 'M'),
(2, 'Kate', 'Winslet', 'F'),
(3, 'Tom', 'Hanks', 'M');

--Insert Directors
INSERT INTO director (dir_id, dir_fname, dir_lname)
VALUES 
(1, 'James', 'Cameron'),
(2, 'Steven', 'Spielberg');

--Insert Movies
INSERT INTO movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES 
(1, 'Titanic', 1997, 195, 'English', '1997-12-19', 'USA'),
(2, 'Saving Private Ryan', 1998, 169, 'English', '1998-07-24', 'USA');

--Insert Reviewers
INSERT INTO reviewer (rev_id, rev_name)
VALUES 
(1, 'Roger Ebert'),
(2, 'Chris Stuckmann');

--Insert Genres
INSERT INTO genres (gen_id, gen_title)
VALUES 
(1, 'Romance'),
(2, 'Action'),
(3, 'Drama'),
(4, 'War');

--Insert Ratings
INSERT INTO rating (mov_id, rev_id, rev_stars, num_o_ratings)
VALUES 
(1, 1, 5, 1000),
(2, 2, 4, 850);

--Insert Movie Genres
INSERT INTO movie_genres (mov_id, gen_id)
VALUES 
(1, 1),  -- Titanic - Romance
(1, 3),  -- Titanic - Drama
(2, 2),  -- Saving Private Ryan - Action
(2, 4);  -- Saving Private Ryan - War

--Insert Movie Cast
INSERT INTO movie_cast (act_id, mov_id, role)
VALUES 
(1, 1, 'Jack Dawson'),
(2, 1, 'Rose DeWitt Bukater'),
(3, 2, 'Captain Miller');

--Insert Movie Direction
INSERT INTO movie_direction (dir_id, mov_id)
VALUES 
(1, 1), -- James Cameron directed Titanic
(2, 2); -- Spielberg directed Saving Private Ryan

--Run Example Queries 
--3-Verify Tables
EXEC sp_tables;

SELECT m.mov_title, g.gen_title
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id;

--Find Movies with Cast and Roles
SELECT m.mov_title, a.act_fname + ' ' + a.act_lname AS actor_name, mc.role
FROM movie m
JOIN movie_cast mc ON m.mov_id = mc.mov_id
JOIN actor a ON mc.act_id = a.act_id;

--Get Movie Ratings
SELECT m.mov_title, r.rev_name, rt.rev_stars, rt.num_o_ratings
FROM rating rt
JOIN movie m ON rt.mov_id = m.mov_id
JOIN reviewer r ON rt.rev_id = r.rev_id;

--List All Directors with Their Movies
SELECT d.dir_fname + ' ' + d.dir_lname AS director_name, m.mov_title
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
JOIN movie m ON md.mov_id = m.mov_id;
