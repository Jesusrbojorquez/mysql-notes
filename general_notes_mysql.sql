/*Connect to mysql*/

mysql -u root -pmypassword

mysql -u root -p

Enter password: mypassword


/*create users
Full info on: https://mariadb.com/kb/en/library/create-user/ */

CREATE USER 'username'@'host' IDENTIFIED BY 'password';

/*Example*/

CREATE USER 'centauri'@'localhost' IDENTIFIED BY 'centauri';

/*show users */

SELECT user FROM mysql.user;
SELECT user, host FROM mysql.user;

/*Granting permissions
Full info on: https://mariadb.com/kb/en/library/grant/ */

GRANT <privileges>	ON <database> TO <user>;

/*Examples*/

GRANT ALL PRIVILEGES ON centauri . * TO 'user1'@'localhost';

/*Revoking permissions
Full info on: https://mariadb.com/kb/en/library/revoke/ */

REVOKE <privileges> ON <database> FROM <user>;

/*Showing permissions*/

SHOW GRANTS FOR <user>;

/*Example*/

SHOW GRANTS FOR 'root'@'localhost';

/*Setting and changing passwords
Full info on: https://mariadb.com/kb/en/library/set-password/ */

SET PASSWORD FOR <user> = PASSWORD('<password>');

/*Example*/

SET PASSWORD FOR 'centauri'@'localhost' = PASSWORD('1234');

/*Removing users
Full info on: https://mariadb.com/kb/en/library/drop-user/ */

DROP USER [IF EXISTS] user_name [, user_name] ...;
DROP USER <user>;

/*Example*/

DROP USER 'centauri'@'localhost';

/*Connecting from the command promt
Note: [] means what is inside is optional
      <> means that if we use this option we must fill in inside*/

mysql [-u <username>] [-p] [-h <host>] [<database>]

mysql [-u <username>] [-p<password>] [-h <host>] [<database>]

/*Example*/

mysql -u root -p
Enter password:


/*Database theory: https://mariadb.com/kb/en/library/database-theory/ */
/*Select a database to use*/

USE <database>;

/*Example*/

USE centauridb;

/*List all databases on a server, both methods valid*/

SHOW DATABASES;
SHOW SCHEMAS;

/*Create database
Full info on: https://mariadb.com/kb/en/create-database/ */

CREATE DATABASE <databasename>;

/*Example*/

CREATE DATABASE centauridb; /*If the database already exists we will receive an error*/
CREATE DATABASE IF NOT EXISTS centauridb;/*If the database already exists it will do nothing*/

/*Delete a database
Full info on: https://mariadb.com/kb/en/library/drop-database/ */

DROP DATABSE <databasename>;

/*Example*/

DROP DATABASE centauridb; /*If the database does not exist we will receive an error*/
DROP DATABASE IF EXISTS centauridb;/*If the database doesn't exists it will do nothing*/

/*Create table
Full info on: https://mariadb.com/kb/en/library/create-table/ */

CREATE TABLE table_name (<column_definitions>);
CREATE TABLE IF NOT EXISTS table_name (<column_definitions>);

/*The <column_definitions> part has the following basic syntax:
Notes:  | means or (exclusive or)
        [] means it is optional
		<> means we need to fill in*/
/* Data types: https://mariadb.com/kb/en/library/data-types/ */

<column_name> <data_type>
[NOT NULL | NULL]
[DEFAULT <default_value>]
[AUTO_INCREMENT]
[UNIQUE [KEY] | [PRIMARY] KEY]
[COMMENT '<string>']

/*Example*/

CREATE TABLE employees(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	surname VARCHAR(100),
	givenname VARCHAR(100),
	pref_name VARCHAR(50),
	birthday DATE COMMENT 'approximate birthday OK'
);

/*Display the command used to create a table
Full info on: https://mariadb.com/kb/en/library/show-create-table/ */

SHOW CREATE TABLE <tablename>;
SHOW CREATE TABLE <tablename> \G

/*Example: */

SHOW CREATE TABLE employees \G /*"\G" replaces ";" if we want the output to be shorter*/
/*
*************************** 1. row ***************************
       Table: employees
Create Table: CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `surname` varchar(100) DEFAULT NULL,
  `givenname` varchar(100) DEFAULT NULL,
  `pref_name` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL COMMENT 'approximate birthday OK',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
1 row in set (0.00 sec)
*/

/*Explore the structure of a table
Full info on: https://mariadb.com/kb/en/library/describe/ */

DESCRIBE <tablename>;

/*Example: */

DESCRIBE employees;
/*
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| id        | int(11)      | NO   | PRI | NULL    | auto_increment |
| surname   | varchar(100) | YES  |     | NULL    |                |
| givenname | varchar(100) | YES  |     | NULL    |                |
| pref_name | varchar(50)  | YES  |     | NULL    |                |
| birthday  | date         | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)
*/

/*To see an specific column, we can specify as follows: */

DESCRIBE <tablename> <column_name>;

/*Example*/

DESCRIBE employees birthday;

/*
+----------+------+------+-----+---------+-------+
| Field    | Type | Null | Key | Default | Extra |
+----------+------+------+-----+---------+-------+
| birthday | date | YES  |     | NULL    |       |
+----------+------+------+-----+---------+-------+
1 row in set (0.01 sec)
*/

/*To change things on the table we use ALTER
Note: <alter_definition> can ADD, MODIFY, and DROP columns
      full info on: https://mariadb.com/kb/en/library/alter-table/ */

ALTER TABLE tablename <alter_definition> [, alter_definition] ... ;

/*Adding a column
Note: If we choose FIRST, the column will be put in the first position */

ALTER TABLE tablename ADD <column_name> <column_definition> [FIRST | AFTER <column_name>];

/*Example*/

ALTER TABLE employees ADD username VARCHAR(20) AFTER pref_name;

/*
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| id        | int(11)      | NO   | PRI | NULL    | auto_increment |
| surname   | varchar(100) | YES  |     | NULL    |                |
| givenname | varchar(100) | YES  |     | NULL    |                |
| pref_name | varchar(50)  | YES  |     | NULL    |                |
| username  | varchar(20)  | YES  |     | NULL    |                |
| birthday  | date         | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)
*/


/*To modify a column we can use ALTER */

MODIFY <column_name> <column_definition>

/*Example*/

ALTER TABLE employees MODIFY pref_name VARCHAR(25);

/*
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| id        | int(11)      | NO   | PRI | NULL    | auto_increment |
| surname   | varchar(100) | YES  |     | NULL    |                |
| givenname | varchar(100) | YES  |     | NULL    |                |
| pref_name | varchar(25)  | YES  |     | NULL    |                |
| username  | varchar(20)  | YES  |     | NULL    |                |
| birthday  | date         | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)
*/

/*To drop a column we can also use ALTER TABLE */

ALTER TABLE tablename DROP <column_name>

/*Example*/

ALTER TABLE employees DROP username;

/*
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| id        | int(11)      | NO   | PRI | NULL    | auto_increment |
| surname   | varchar(100) | YES  |     | NULL    |                |
| givenname | varchar(100) | YES  |     | NULL    |                |
| pref_name | varchar(25)  | YES  |     | NULL    |                |
| birthday  | date         | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)
*/

/*To delete a table we use DROP TABLE
Full documentation: https://mariadb.com/kb/en/drop-table */

DROP TABLE <tablename>

/*Example*/

DROP TABLE mytable;

DROP TABLE IF EXISTS mytable;


/*To put data into our database, we use the INSERT command
Note: <> Are replaced with our own values
      [] Are optional
	  |  Means exclusive or
	  {} Specify a mandatory section
	     The expression part is the value we want to put in a column
		 Full documentation: https://mariadb.com/kb/en/insert */

INSERT [INTO] <tablename> [(<column_name>[, <column_name>, ...)]
{VALUES | VALUE}
({<expression>|DEFAULT}, ...)[, (...), ...];

/*Example: */

INSERT INTO employees VALUES (NULL, "Perry", "Lowell Tom", "Tom", "1988-08-05");

/*
mysql> SELECT * FROM EMPLOYEES;
+----+---------+------------+-----------+------------+
| id | surname | givenname  | pref_name | birthday   |
+----+---------+------------+-----------+------------+
|  1 | Perry   | Lowell Tom | Tom       | 1988-08-05 |
+----+---------+------------+-----------+------------+
1 row in set (0.00 sec)
*/

INSERT INTO employees VALUES (NULL, "Pratt", "Parley", NULL, NULL), (NULL, "Snow", "Eliza", NULL, NULL);
/*
mysql> SELECT * FROM EMPLOYEES;
+----+---------+------------+-----------+------------+
| id | surname | givenname  | pref_name | birthday   |
+----+---------+------------+-----------+------------+
|  1 | Perry   | Lowell Tom | Tom       | 1988-08-05 |
|  2 | Pratt   | Parley     | NULL      | NULL       |
|  3 | Snow    | Eliza      | NULL      | NULL       |
+----+---------+------------+-----------+------------+
3 rows in set (0.00 sec)
*/

/*To insert a partial row we do like this*/

INSERT INTO employees (surname, givenname) VALUES ("Taylor", "John"), ("Woodruff", "Wildford"), ("Snow", "Lorenzo");
/*
mysql> SELECT * FROM employees;
+----+----------+------------+-----------+------------+
| id | surname  | givenname  | pref_name | birthday   |
+----+----------+------------+-----------+------------+
|  1 | Perry    | Lowell Tom | Tom       | 1988-08-05 |
|  2 | Pratt    | Parley     | NULL      | NULL       |
|  3 | Snow     | Eliza      | NULL      | NULL       |
|  4 | Taylor   | John       | NULL      | NULL       |
|  5 | Woodruff | Wildford   | NULL      | NULL       |
|  6 | Snow     | Lorenzo    | NULL      | NULL       |
+----+----------+------------+-----------+------------+
6 rows in set (0.00 sec)
*/

/*We can change the order in which we fill in the columns, but the order in the table does not change*/

INSERT INTO employees (pref_name, givenname, surname, birthday) VALUES ("George", "George Albert", "Smith", "1970-04-04");
/*
mysql> SELECT * FROM employees;
+----+----------+---------------+-----------+------------+
| id | surname  | givenname     | pref_name | birthday   |
+----+----------+---------------+-----------+------------+
|  1 | Perry    | Lowell Tom    | Tom       | 1988-08-05 |
|  2 | Pratt    | Parley        | NULL      | NULL       |
|  3 | Snow     | Eliza         | NULL      | NULL       |
|  4 | Taylor   | John          | NULL      | NULL       |
|  5 | Woodruff | Wildford      | NULL      | NULL       |
|  6 | Snow     | Lorenzo       | NULL      | NULL       |
|  7 | Smith    | George Albert | George    | 1970-04-04 |
+----+----------+---------------+-----------+------------+
7 rows in set (0.00 sec)
*/

/*To fill one value we can just write VALUE instead of VALUES*/

INSERT INTO employees (surname) VALUE ("McKay");
/*
mysql> SELECT * FROM employees;
+----+----------+---------------+-----------+------------+
| id | surname  | givenname     | pref_name | birthday   |
+----+----------+---------------+-----------+------------+
|  1 | Perry    | Lowell Tom    | Tom       | 1988-08-05 |
|  2 | Pratt    | Parley        | NULL      | NULL       |
|  3 | Snow     | Eliza         | NULL      | NULL       |
|  4 | Taylor   | John          | NULL      | NULL       |
|  5 | Woodruff | Wildford      | NULL      | NULL       |
|  6 | Snow     | Lorenzo       | NULL      | NULL       |
|  7 | Smith    | George Albert | George    | 1970-04-04 |
|  8 | McKay    | NULL          | NULL      | NULL       |
+----+----------+---------------+-----------+------------+
8 rows in set (0.00 sec)
*/

/*To insert data from another table we use the next syntax:
Full documentation: https://mariadb.com/kb/en/insert-select/ */

INSERT INTO <table_1> [(<column_name>[, <column_name>, ...])]
SELECT <column_name>[, <column_name>, ...]
FROM <table_2>;

/*Example: */

INSERT INTO employees (surname, givenname, birthday) SELECT lastname, firstname, bday FROM names;

/*Insert data from a file
Notes: -if the LOCAL option is used, it will look for the file on the filesystem that we are running our client on,
       otherwise it will look in its own filesystem*/
LOAD DATA [LOCAL] INFILE '<filename>'
INTO TABLE <tablename>
[(<column_name>[, <column_name>, ...])];

/*Example
Note: we explicitly tells the command that the lines terminates in '\r\n' because we are in a windows machine
      full documentation: https://mariadb.com/kb/en/load-data-infile/
	                      https://dev.mysql.com/doc/refman/5.7/en/load-data-local.html*/

LOAD DATA LOCAL INFILE 'D:/CursosPresenciales/FullStack/JESUS/Programs/testrow.txt' INTO TABLE employees LINES TERMINATED BY '\r\n'  (id, birthday, surname, givenname);
/*
mysql> select * from employees;
+----+----------------+------------+-----------+------------+
| id | surname        | givenname  | pref_name | birthday   |
+----+----------------+------------+-----------+------------+
|  1 | Perry          | Lowell Tom | Tom       | 1988-08-05 |
|  2 | Pratt          | Parley     | NULL      | NULL       |
|  3 | Snow           | Eliza      | NULL      | NULL       |
|  4 | Taylor         | John       | NULL      | NULL       |
|  5 | Woodruff       | Wildford   | NULL      | NULL       |
|  6 | Snow           | Lorenzo    | NULL      | NULL       |
|  7 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 51 | NULL           | NULL       | NULL      | NULL       |
| 52 | Christofferson | Todd       | NULL      | 1985-01-24 |
| 53 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 54 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 55 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 56 | Anderson       | Neil       | NULL      | 1971-08-09 |
+----+----------------+------------+-----------+------------+
13 rows in set (0.00 sec)
*/

/*When data in a table needs to be changed we use UPDATE*/

UPDATE <tablename> SET column_name1={expression|DEFAULT} [, column_name2={expression|DEFAULT}] ... [WHERE <where_conditions>];

/*Example*/

UPDATE employees SET pref_name = "John", birthday="1958-11-01" WHERE surname = "Taylor" AND givenname = "John";

UPDATE employees SET pref_name = "Will", birthday = "1957-03-01" WHERE surname = "Woodruff";

UPDATE employees SET birthday = "1964-04-03" WHERE surname = "Snow";

/*
mysql> SELECT * FROM employees;
+----+----------------+------------+-----------+------------+
| id | surname        | givenname  | pref_name | birthday   |
+----+----------------+------------+-----------+------------+
|  1 | Perry          | Lowell Tom | Tom       | 1988-08-05 |
|  2 | Pratt          | Parley     | NULL      | NULL       |
|  3 | Snow           | Eliza      | NULL      | 1964-04-03 |
|  4 | Taylor         | John       | John      | 1958-11-01 |
|  5 | Woodruff       | Wildford   | Will      | 1957-03-01 |
|  6 | Snow           | Lorenzo    | NULL      | 1964-04-03 |
|  7 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 51 | NULL           | NULL       | NULL      | NULL       |
| 52 | Christofferson | Todd       | NULL      | 1985-01-24 |
| 53 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 54 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 55 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 56 | Anderson       | Neil       | NULL      | 1971-08-09 |
+----+----------------+------------+-----------+------------+
13 rows in set (0.00 sec)
*/

/*To delete information we use DELETE
Full documentation: https://mariadb.com/kb/en/delete/ */

DELETE FROM <tablename> [WHERE <where_condition>]

/*Examples*/

DELETE FROM employees WHERE birthday = '0000-00-00';

DELETE FROM employees WHERE id BETWEEN 8 AND 30;

DELETE FROM employees WHERE givenname = "Spencer" AND surname = "Kimball";

/*To retrieve data we use SELECT
Note: int the <what> part we specify the columns that we want to retrieve*/

SELECT <what> FROM <table_name> [WHERE <conditions>] [ORDER BY <column_name>];

/*Retrieving everything*/

SELECT * FROM employees;
/*
mysql> select * from employees;
+----+----------------+---------------+-----------+------------+
| id | surname        | givenname     | pref_name | birthday   |
+----+----------------+---------------+-----------+------------+
|  1 | Perry          | Lowell Tom    | Tom       | 1988-08-05 |
|  2 | Pratt          | Parley        | NULL      | 1975-04-12 |
|  3 | Snow           | Eliza         | NULL      | 1964-04-03 |
|  4 | Taylor         | John          | John      | 1958-11-01 |
|  5 | Woodruff       | Wildford      | Will      | 1957-03-01 |
|  6 | Snow           | Lorenzo       | NULL      | 1964-04-03 |
|  7 | Smith          | George Albert | George    | 1970-04-04 |
|  8 | McKay          | NULL          | NULL      | 0000-00-00 |
|  9 | Anderson       | Neil          | NULL      | 1971-08-09 |
| 10 | Christofferson | Todd          | NULL      | 1985-01-24 |
+----+----------------+---------------+-----------+------------+
10 rows in set (0.00 sec)
*/

/*Retrieving selected columns*/

SELECT givenname, surname FROM employees;
/*
+---------------+----------------+
| givenname     | surname        |
+---------------+----------------+
| Lowell Tom    | Perry          |
| Parley        | Pratt          |
| Eliza         | Snow           |
| John          | Taylor         |
| Wildford      | Woodruff       |
| Lorenzo       | Snow           |
| George Albert | Smith          |
| NULL          | McKay          |
| Neil          | Anderson       |
| Todd          | Christofferson |
+---------------+----------------+
10 rows in set (0.00 sec)
*/

/*Filtering by exact values
Comparison operators: https://mariadb.com/kb/en/comparison-operators */

SELECT * FROM employees WHERE birthday >= '1970-01-01';

/*
+----+----------------+---------------+-----------+------------+
| id | surname        | givenname     | pref_name | birthday   |
+----+----------------+---------------+-----------+------------+
|  1 | Perry          | Lowell Tom    | Tom       | 1988-08-05 |
|  2 | Pratt          | Parley        | NULL      | 1975-04-12 |
|  7 | Smith          | George Albert | George    | 1970-04-04 |
|  9 | Anderson       | Neil          | NULL      | 1971-08-09 |
| 10 | Christofferson | Todd          | NULL      | 1985-01-24 |
+----+----------------+---------------+-----------+------------+
5 rows in set (0.00 sec)
*/

/*Using the AND operator*/

SELECT * FROM employees WHERE surname = 'Snow' AND givenname LIKE 'eli%';
/*
+----+---------+-----------+-----------+------------+
| id | surname | givenname | pref_name | birthday   |
+----+---------+-----------+-----------+------------+
|  3 | Snow    | Eliza     | NULL      | 1964-04-03 |
+----+---------+-----------+-----------+------------+
1 row in set (0.01 sec)
*/

/*Using the OR operator*/

SELECT * FROM employees WHERE givenname = 'Neil' OR givenname = 'John';
/*
+----+----------+-----------+-----------+------------+
| id | surname  | givenname | pref_name | birthday   |
+----+----------+-----------+-----------+------------+
|  4 | Taylor   | John      | John      | 1958-11-01 |
|  9 | Anderson | Neil      | NULL      | 1971-08-09 |
+----+----------+-----------+-----------+------------+
2 rows in set (0.00 sec)
*/

/*Using the IN operator*/

SELECT * FROM employees WHERE surname = 'Snow' OR surname = 'Smith' OR surname = 'Pratt';

SELECT * FROM employees WHERE surname IN ('Snow', 'Smith', 'Pratt');
/*
+----+---------+---------------+-----------+------------+
| id | surname | givenname     | pref_name | birthday   |
+----+---------+---------------+-----------+------------+
|  2 | Pratt   | Parley        | NULL      | 1975-04-12 |
|  3 | Snow    | Eliza         | NULL      | 1964-04-03 |
|  6 | Snow    | Lorenzo       | NULL      | 1964-04-03 |
|  7 | Smith   | George Albert | George    | 1970-04-04 |
+----+---------+---------------+-----------+------------+
4 rows in set (0.00 sec)
*/

/*Using the NOT operator*/

SELECT * FROM employees WHERE surname NOT IN ('Snow', 'Smith', 'Pratt');
/*
+----+----------------+------------+-----------+------------+
| id | surname        | givenname  | pref_name | birthday   |
+----+----------------+------------+-----------+------------+
|  1 | Perry          | Lowell Tom | Tom       | 1988-08-05 |
|  4 | Taylor         | John       | John      | 1958-11-01 |
|  5 | Woodruff       | Wildford   | Will      | 1957-03-01 |
|  8 | McKay          | NULL       | NULL      | 0000-00-00 |
|  9 | Anderson       | Neil       | NULL      | 1971-08-09 |
| 10 | Christofferson | Todd       | NULL      | 1985-01-24 |
+----+----------------+------------+-----------+------------+
6 rows in set (0.00 sec)
*/

/*Searching with like*/

SELECT * FROM employees WHERE surname LIKE "McK%";
/*
+----+---------+-----------+-----------+------------+
| id | surname | givenname | pref_name | birthday   |
+----+---------+-----------+-----------+------------+
|  8 | McKay   | NULL      | NULL      | 0000-00-00 |
+----+---------+-----------+-----------+------------+
1 row in set (0.00 sec)
*/

/*Sorting data*/

SELECT * FROM employees WHERE birthday >= '1970-01-01' ORDER BY surname;
/*
+----+----------------+---------------+-----------+------------+
| id | surname        | givenname     | pref_name | birthday   |
+----+----------------+---------------+-----------+------------+
|  9 | Anderson       | Neil          | NULL      | 1971-08-09 |
| 10 | Christofferson | Todd          | NULL      | 1985-01-24 |
|  1 | Perry          | Lowell Tom    | Tom       | 1988-08-05 |
|  2 | Pratt          | Parley        | NULL      | 1975-04-12 |
|  7 | Smith          | George Albert | George    | 1970-04-04 |
+----+----------------+---------------+-----------+------------+
5 rows in set (0.00 sec)
*/


/*Joining data
Full documentation: https://mariadb.com/kb/en/join/ */

CREATE TABLE phone ( id serial PRIMARY KEY, emp_id INT, type CHAR(3), cc INT(4), number BIGINT, ext INT);

INSERT INTO phone (emp_id, type, cc, number, ext) VALUES (1,'wrk',1,1235551212,23), (1,'hom',1,1235559876,NULL), (1,'mob',1,1235553434,NULL), (2,'wrk',1,1235551212,32), (3,'wrk',1,1235551212,11), (4,'mob',1,3215559821,NULL), (4,'hom',1,3215551234,NULL);
/*
mysql> SELECT * FROM phone;
+----+--------+------+------+------------+------+
| id | emp_id | type | cc   | number     | ext  |
+----+--------+------+------+------------+------+
|  1 |      1 | wrk  |    1 | 1235551212 |   23 |
|  2 |      1 | hom  |    1 | 1235559876 | NULL |
|  3 |      1 | mob  |    1 | 1235553434 | NULL |
|  4 |      2 | wrk  |    1 | 1235551212 |   32 |
|  5 |      3 | wrk  |    1 | 1235551212 |   11 |
|  6 |      4 | mob  |    1 | 3215559821 | NULL |
|  7 |      4 | hom  |    1 | 3215551234 | NULL |
+----+--------+------+------+------------+------+
7 rows in set (0.00 sec)
*/

SELECT surname, givenname, type, cc, number, ext FROM employees JOIN phone ON employees.id = phone.emp_id;
/*
+---------+------------+------+------+------------+------+
| surname | givenname  | type | cc   | number     | ext  |
+---------+------------+------+------+------------+------+
| Perry   | Lowell Tom | wrk  |    1 | 1235551212 |   23 |
| Perry   | Lowell Tom | hom  |    1 | 1235559876 | NULL |
| Perry   | Lowell Tom | mob  |    1 | 1235553434 | NULL |
| Pratt   | Parley     | wrk  |    1 | 1235551212 |   32 |
| Snow    | Eliza      | wrk  |    1 | 1235551212 |   11 |
| Taylor  | John       | mob  |    1 | 3215559821 | NULL |
| Taylor  | John       | hom  |    1 | 3215551234 | NULL |
+---------+------------+------+------+------------+------+
7 rows in set (0.02 sec)
*/
edit
