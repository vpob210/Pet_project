/*CREATE DATABASE todo_app;*/

/* баловство */
/* USE todo_app;*/
/*Загружаем дамп из файла */
/*SOURCE /docker-entrypoint-initdb.d/simple_app.sql;*/

CREATE USER 'todo_user'@'172.18.0.3' IDENTIFIED BY 'vpob';
GRANT ALL PRIVILEGES ON todo_app.* TO 'todo_user'@'172.18.0.3';
FLUSH PRIVILEGES;
