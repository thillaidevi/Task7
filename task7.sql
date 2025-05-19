# Step 1: Create the Database:

CREATE DATABASE IMDB;
SHOW DATABASES;
USE IMDB; 

# Step 2: Create Tables: Movies table creation

CREATE TABLE movies (
    ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Release_year INT,
    Director VARCHAR(100)
);

select * from movies;

# Insert Sample Data
# Adding a Movie:

INSERT INTO movies
VALUES (1, 'Thani Oruvan', 2015,'Mohan Raja');

select * from movies;

# Media Table (Movies can have multiple images/videos)

CREATE TABLE media (
    Id INT PRIMARY KEY,
    Movie_id INT,
    Media_type VARCHAR(50), -- 'video', 'image'
    Media_url VARCHAR(255),   
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

# Adding Media (Images/Videos):

INSERT INTO media
VALUES (1, 1, 'Thani_Oruvan.jpg', 'https://en.wikipedia.org/wiki/Thani_Oruvan#/media/File:Thani_Oruvan.jpg'),
       (2, 1, 'Thani_Oruvan_trailer', 'https://www.youtube.com/watch?v=r5Lih8rKd6k');

select * from media;

# Genres Table and movie_genres table (Movies can belong to multiple genres)

CREATE TABLE genres (
    id INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE
);

select * from genres;

CREATE TABLE movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

select * from movie_genres;

# Adding Genres & Linking to Movie:

INSERT INTO genres (id, name)
VALUES (1, 'Social-Message'), (2, 'Action'), (3, 'Thriller');

select * from genres;

INSERT INTO movie_genres (movie_id, genre_id)
VALUES (1, 1), (1, 2), (1, 3); -- Social-Message, Action, Thriller

select * from movie_genres;

# Users Table Reviews belong to users

CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);

select * from users;

# Reviews Table Movies can have multiple reviews

CREATE TABLE reviews (
    id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    rating DECIMAL(2,1),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

select * from reviews;

# Adding Users & Reviews:
INSERT INTO users (id, username, email)
VALUES (1, 'Rajesh123', 'rajesh@example.com');

select * from users;

INSERT INTO reviews (id, user_id, movie_id, rating, comment)
VALUES (1, 1, 1, 4.8, 'Amazing movie with mind-blowing visuals!');

select * from reviews;

# Artists Table (Artists can have multiple skills)

CREATE TABLE artists (

    id INT PRIMARY KEY,
    name VARCHAR(100),
    birth_year INT
);

select * from artists;

# Skills table creation

CREATE TABLE skills (
    id INT PRIMARY KEY,
    skill_name VARCHAR(50) UNIQUE
);
select * from skills;

# Create artist_skills table:

CREATE TABLE artist_skills (
    artist_id INT,
    skill_id INT,
    PRIMARY KEY (artist_id, skill_id),
    FOREIGN KEY (artist_id) REFERENCES artists(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
);

select * from artist_skills;

#Adding Artists & Skills:

INSERT INTO artists VALUES (1,'Ravi Mohan', 1980 );

select * from artists;

INSERT INTO skills (id, skill_name)
VALUES (1, 'Acting'), (2, 'Producing');

select * from skills;

INSERT INTO artist_skills (artist_id, skill_id)
VALUES (1, 1), (1, 2); -- Ravi Mohan: Acting, Producing

select * from artist_skills;

#Artist Roles Table Artists can perform multiple roles in a single film

CREATE TABLE artist_roles (
    movie_id INT,
    artist_id INT,
    role VARCHAR(50),
    PRIMARY KEY (movie_id, artist_id, role),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (artist_id) REFERENCES artists(id)
);

select * from artist_roles;

#Assigning Roles in a Movie:

INSERT INTO artist_roles (movie_id, artist_id, role)
VALUES (1, 1, 'Actor'), (1, 1, 'Producer'); -- Ravi Mohan as Actor & Producer

select * from artist_roles;

#Retrieval Queries:

#Get All Media for a Movie

SELECT * FROM media WHERE movie_id = 1;

SELECT Media_url FROM media WHERE Media_type = 'Thani_Oruvan.jpg';

#Get All Genres for a Movie

SELECT g.name FROM genres g
JOIN movie_genres mg ON g.id = mg.genre_id
WHERE mg.movie_id = 1;

#Get All Reviews for a Movie:

SELECT u.username, r.rating, r.comment
FROM reviews r
JOIN users u ON r.user_id = u.id
WHERE r.movie_id = 1;

# Get All Skills for an Artist

SELECT s.skill_name FROM skills s
JOIN artist_skills a ON s.id = a.skill_id
WHERE a.artist_id = 1;

# Get All Roles an Artist Performed in a Movie

SELECT role FROM artist_roles
WHERE movie_id = 1 AND artist_id = 1;



