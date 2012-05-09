Project 3 for AJAX Web Development, Spring 2012


Javascript and AJAX Web Development
20 Points
10-152-168
Project 3 Overview

This lab will serve as a hands-on introduction to jQuery. It will also expose students javascript web applications
Project Requirements

You should create a mysql database named blog
Use the sql statements listed below to generate the database and table structure for the lab 
      CREATE DATABASE  `blog` ;

               CREATE TABLE  `blog`.`users` (
               `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
               `user_id` VARCHAR( 500 ) NOT NULL ,
               `password` VARCHAR( 500 ) NOT NULL ,
               `created` DATETIME NOT NULL
               ) ENGINE = INNODB;
               CREATE TABLE  `blog`.`posts` (
               `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
               `user_id` VARCHAR( 500 ) NOT NULL ,
               `title` VARCHAR( 500 ) NOT NULL ,
              `description` VARCHAR( 500 ) NOT NULL ,`created` DATETIME NOT NULL
               ) ENGINE = INNODB;
               
               CREATE TABLE  `blog`.`comments` (
               `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
               `user_id` VARCHAR( 500 ) NOT NULL ,
               `post_id` INT NOT NULL ,
               `description` VARCHAR ( 500 ) ,`created` DATETIME NOT NULL             ) ENGINE = INNODB;
create a login page that authenticates users against the users table - if the user is valid, allow the user to navigate to a page that displays all posts and their related comments. Otherwise, if the user is invalid display an error message.
the blog posts page should meet the following criteria
there can be no submits. all server interaction must be done using ajax
display all posts (just the description) 
allow entry of a new post - the post should get saved to the posts table and should update the user-interface (it should be added to the list of all posts)
allow any post in the list of all posts to be deleted (only if the currently logged in user created the post) - it should be removed from the db and from the user-interface. The delete process should NOT remove the corresponding comments.
allow the user to comment on any post - the comment should get saved to the comments table and update the user interface (it should appear next to the related post)
all comments that originated from the currently logged in user should be highlighted (ex. a different background color) from posts by other users