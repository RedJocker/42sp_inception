-- Create a database
CREATE DATABASE IF NOT EXISTS my_db;

-- Create a user and grant privileges
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON my_db.* TO 'root'@'%';
FLUSH PRIVILEGES;
