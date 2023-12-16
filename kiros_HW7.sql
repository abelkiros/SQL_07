mysql> DROP DATABASE kiros_ACMEOnline;
--------------
DROP DATABASE kiros_ACMEOnline
--------------

Query OK, 6 rows affected (0.02 sec)

mysql> CREATE DATABASE kiros_ACMEOnline;
--------------
CREATE DATABASE kiros_ACMEOnline
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> USE kiros_ACMEOnline;
Database changed
mysql> 
mysql> CREATE TABLE ITEM
    -> (
    ->     Item_Number INT
    ->     UNSIGNED AUTO_INCREMENT, 
    ->     Item_Name VARCHAR(35) NOT NULL,
    ->     Description VARCHAR(255),
    ->     Model VARCHAR(50) NOT NULL,
    ->     Price VARCHAR(9) NOT NULL,
    ->     CONSTRAINT item_pk PRIMARY KEY (Item_Number)
    -> );
--------------
CREATE TABLE ITEM
(
    Item_Number INT
    UNSIGNED AUTO_INCREMENT, 
    Item_Name VARCHAR(35) NOT NULL,
    Description VARCHAR(255),
    Model VARCHAR(50) NOT NULL,
    Price VARCHAR(9) NOT NULL,
    CONSTRAINT item_pk PRIMARY KEY (Item_Number)
)
--------------

Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DESCRIBE ITEM;
--------------
DESCRIBE ITEM
--------------

+-------------+------------------+------+-----+---------+----------------+
| Field       | Type             | Null | Key | Default | Extra          |
+-------------+------------------+------+-----+---------+----------------+
| Item_Number | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| Item_Name   | varchar(35)      | NO   |     | NULL    |                |
| Description | varchar(255)     | YES  |     | NULL    |                |
| Model       | varchar(50)      | NO   |     | NULL    |                |
| Price       | varchar(9)       | NO   |     | NULL    |                |
+-------------+------------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> 
mysql> CREATE TABLE CUSTOMER
    -> (
    ->     CustomerID INT
    ->     UNSIGNED NOT NULL AUTO_INCREMENT,
    ->     CustomerName VARCHAR(100),
    ->     Address VARCHAR(150) NOT NULL,
    ->     Email VARCHAR(80),
    ->     bussiness_or_home ENUM ('b', 'h'),
    ->     CONSTRAINT customer_pk PRIMARY KEY(CustomerID)
    -> );
--------------
CREATE TABLE CUSTOMER
(
    CustomerID INT
    UNSIGNED NOT NULL AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    Address VARCHAR(150) NOT NULL,
    Email VARCHAR(80),
    bussiness_or_home ENUM ('b', 'h'),
    CONSTRAINT customer_pk PRIMARY KEY(CustomerID)
)
--------------

Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> 
mysql> DESCRIBE CUSTOMER;
--------------
DESCRIBE CUSTOMER
--------------

+-------------------+------------------+------+-----+---------+----------------+
| Field             | Type             | Null | Key | Default | Extra          |
+-------------------+------------------+------+-----+---------+----------------+
| CustomerID        | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| CustomerName      | varchar(100)     | YES  |     | NULL    |                |
| Address           | varchar(150)     | NO   |     | NULL    |                |
| Email             | varchar(80)      | YES  |     | NULL    |                |
| bussiness_or_home | enum('b','h')    | YES  |     | NULL    |                |
+-------------------+------------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> 
mysql> CREATE TABLE ORDERED
    -> (
    ->     OrderID INT
    ->     UNSIGNED AUTO_INCREMENT, /*fK */
    ->     total_cost VARCHAR(11),
    ->     CustomerID INT UNSIGNED NOT NULL, /*fK */
    ->     CONSTRAINT ordered_pk PRIMARY KEY(OrderID),
    ->     CONSTRAINT ordered_CustomerID_fk FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
    -> );
--------------
CREATE TABLE ORDERED
(
    OrderID INT
    UNSIGNED AUTO_INCREMENT, 
    total_cost VARCHAR(11),
    CustomerID INT UNSIGNED NOT NULL, 
    CONSTRAINT ordered_pk PRIMARY KEY(OrderID),
    CONSTRAINT ordered_CustomerID_fk FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
)
--------------

Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DESCRIBE ORDERED;
--------------
DESCRIBE ORDERED
--------------

+------------+------------------+------+-----+---------+----------------+
| Field      | Type             | Null | Key | Default | Extra          |
+------------+------------------+------+-----+---------+----------------+
| OrderID    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| total_cost | varchar(11)      | YES  |     | NULL    |                |
| CustomerID | int(10) unsigned | NO   | MUL | NULL    |                |
+------------+------------------+------+-----+---------+----------------+
3 rows in set (0.01 sec)

mysql> 
mysql> CREATE TABLE LINE_ITEM
    -> (
    ->     OrderID INT
    ->     UNSIGNED NOT NULL ,
    ->     Item_Number INT UNSIGNED NOT NULL, 
    ->     quantity TINYINT(255) NOT NULL,
    ->     CONSTRAINT line_item_pk PRIMARY KEY(Item_Number, OrderID),
    ->     CONSTRAINT line_item_fk FOREIGN KEY(Item_Number) REFERENCES ITEM(Item_Number),
    ->     CONSTRAINT line_item_orderID_fk FOREIGN KEY(OrderID) REFERENCES ORDERED(OrderID)
    -> );
--------------
CREATE TABLE LINE_ITEM
(
    OrderID INT
    UNSIGNED NOT NULL ,
    Item_Number INT UNSIGNED NOT NULL, 
    quantity TINYINT(255) NOT NULL,
    CONSTRAINT line_item_pk PRIMARY KEY(Item_Number, OrderID),
    CONSTRAINT line_item_fk FOREIGN KEY(Item_Number) REFERENCES ITEM(Item_Number),
    CONSTRAINT line_item_orderID_fk FOREIGN KEY(OrderID) REFERENCES ORDERED(OrderID)
)
--------------

Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DESCRIBE LINE_ITEM;
--------------
DESCRIBE LINE_ITEM
--------------

+-------------+------------------+------+-----+---------+-------+
| Field       | Type             | Null | Key | Default | Extra |
+-------------+------------------+------+-----+---------+-------+
| OrderID     | int(10) unsigned | NO   | PRI | NULL    |       |
| Item_Number | int(10) unsigned | NO   | PRI | NULL    |       |
| quantity    | tinyint(255)     | NO   |     | NULL    |       |
+-------------+------------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> 
mysql> CREATE TABLE HOME
    -> (
    ->     CustomerID INT
    ->     UNSIGNED NOT NULL,
    ->     CreditCardNum char(16) NOT NULL,
    ->     CreditCardExpirationDate char(6) NOT NULL,
    ->     CONSTRAINT home_pk PRIMARY KEY(CustomerID , CreditCardNum),
    ->     CONSTRAINT home_customer_fk FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
    -> );
--------------
CREATE TABLE HOME
(
    CustomerID INT
    UNSIGNED NOT NULL,
    CreditCardNum char(16) NOT NULL,
    CreditCardExpirationDate char(6) NOT NULL,
    CONSTRAINT home_pk PRIMARY KEY(CustomerID , CreditCardNum),
    CONSTRAINT home_customer_fk FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
)
--------------

Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DESCRIBE HOME;
--------------
DESCRIBE HOME
--------------

+--------------------------+------------------+------+-----+---------+-------+
| Field                    | Type             | Null | Key | Default | Extra |
+--------------------------+------------------+------+-----+---------+-------+
| CustomerID               | int(10) unsigned | NO   | PRI | NULL    |       |
| CreditCardNum            | char(16)         | NO   | PRI | NULL    |       |
| CreditCardExpirationDate | char(6)          | NO   |     | NULL    |       |
+--------------------------+------------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> 
mysql> CREATE TABLE BUSINESS
    -> (
    ->     CustomerID INT UNSIGNED NOT NULL,
    ->     PaymentTerms VARCHAR(50) NOT NULL,
    ->     CONSTRAINT business_pk PRIMARY KEY(CustomerID,PaymentTerms),
    ->     CONSTRAINT business_customer_fk FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
    -> );
--------------
CREATE TABLE BUSINESS
(
    CustomerID INT UNSIGNED NOT NULL,
    PaymentTerms VARCHAR(50) NOT NULL,
    CONSTRAINT business_pk PRIMARY KEY(CustomerID,PaymentTerms),
    CONSTRAINT business_customer_fk FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
)
--------------

Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DESCRIBE BUSINESS;
--------------
DESCRIBE BUSINESS
--------------

+--------------+------------------+------+-----+---------+-------+
| Field        | Type             | Null | Key | Default | Extra |
+--------------+------------------+------+-----+---------+-------+
| CustomerID   | int(10) unsigned | NO   | PRI | NULL    |       |
| PaymentTerms | varchar(50)      | NO   | PRI | NULL    |       |
+--------------+------------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

mysql> 
mysql> INSERT INTO ITEM(Item_Name, Description, Model, Price) VALUES ('Cabbage Patch Doll', 'Baby boy doll', 'Boy', '39.95');
--------------
INSERT INTO ITEM(Item_Name, Description, Model, Price) VALUES ('Cabbage Patch Doll', 'Baby boy doll', 'Boy', '39.95')
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> INSERT INTO ITEM(Item_Name, Description, Model, Price) VALUES ('The Last Lecture','', 'Hardcover', '9.95');
--------------
INSERT INTO ITEM(Item_Name, Description, Model, Price) VALUES ('The Last Lecture','', 'Hardcover', '9.95')
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> INSERT INTO ITEM (Item_Name, Description, Model, Price) VALUES ('Keurig Beverage Maker', 'Keurig Platinum Edition Beverage Maker in Red', 'Platinum Edition', '299.95');
--------------
INSERT INTO ITEM (Item_Name, Description, Model, Price) VALUES ('Keurig Beverage Maker', 'Keurig Platinum Edition Beverage Maker in Red', 'Platinum Edition', '299.95')
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> SELECT *
    -> FROM ITEM;
--------------
SELECT *
FROM ITEM
--------------

+-------------+-----------------------+-----------------------------------------------+------------------+--------+
| Item_Number | Item_Name             | Description                                   | Model            | Price  |
+-------------+-----------------------+-----------------------------------------------+------------------+--------+
|           1 | Cabbage Patch Doll    | Baby boy doll                                 | Boy              | 39.95  |
|           2 | The Last Lecture      |                                               | Hardcover        | 9.95   |
|           3 | Keurig Beverage Maker | Keurig Platinum Edition Beverage Maker in Red | Platinum Edition | 299.95 |
+-------------+-----------------------+-----------------------------------------------+------------------+--------+
3 rows in set (0.00 sec)

mysql> 
mysql> ALTER TABLE CUSTOMER 
    -> MODIFY COLUMN Address VARCHAR(100);
--------------
ALTER TABLE CUSTOMER 
MODIFY COLUMN Address VARCHAR(100)
--------------

Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> ALTER TABLE CUSTOMER 
    -> ADD COLUMN City VARCHAR(60);
--------------
ALTER TABLE CUSTOMER 
ADD COLUMN City VARCHAR(60)
--------------

Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> ALTER TABLE CUSTOMER
    -> ADD COLUMN State CHAR(2);
--------------
ALTER TABLE CUSTOMER
ADD COLUMN State CHAR(2)
--------------

Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> ALTER TABLE CUSTOMER
    -> ADD COLUMN Zipcode decimal(5,4);
--------------
ALTER TABLE CUSTOMER
ADD COLUMN Zipcode decimal(5,4)
--------------

Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> ALTER TABLE CUSTOMER
    -> DROP COLUMN Zipcode;
--------------
ALTER TABLE CUSTOMER
DROP COLUMN Zipcode
--------------


ALTER TABLE CUSTOMER
ADD COLUMN Zipcode varchar(5);

DELETE FROM ITEM
WHERE Item_Name = 'Keurig Beverage Maker' and item_number = 3;

UPDATE ITEM
SET Description = 'Written by Randy Pausch'
WHERE Description = '';

select * from CUSTOMER;
INSERT INTO CUSTOMER(CustomerID,CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
VALUES(1,'Janine Jeffers', '152 Lomb Memorial Dr.', 'Rochester', 'NY', '14623', 'jxj1234@rit.edu','h');
INSERT INTO CUSTOMER(CustomerID,CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
VALUES(2,'Janine John', '152 Lomb Avenue Dr.', 'Avenue', 'NY', '82269', 'adsa@rit.edu','o');

select * from HOME;
INSERT INTO HOME VALUES (1,'1234567890123456', '012014');

UPDATE Customer
SET bussiness_or_home = 'h'
WHERE EMAIL = 'jxj1234@rit.edu';

select * from ORDERED;
INSERT INTO ORDERED VALUES (1, '113.74',1);
INSERT INTO ORDERED VALUES (2, '113.74',2);

select * from CUSTOMER;
select * from LINE_ITEM;
SELECT *
FROM ITEM;
select * from ORDEREQuery OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> ALTER TABLE CUSTOMER
    -> ADD COLUMN Zipcode varchar(5);
--------------
ALTER TABLE CUSTOMER
ADD COLUMN Zipcode varchar(5)
--------------

Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> DELETE FROM ITEM
    -> WHERE Item_Name = 'Keurig Beverage Maker' and item_number = 3;
--------------
DELETE FROM ITEM
WHERE Item_Name = 'Keurig Beverage Maker' and item_number = 3
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> UPDATE ITEM
    -> SET Description = 'Written by Randy Pausch'
    -> WHERE Description = '';
--------------
UPDATE ITEM
SET Description = 'Written by Randy Pausch'
WHERE Description = ''
--------------

Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> 
mysql> select * from CUSTOMER;
--------------
select * from CUSTOMER
--------------

Empty set (0.01 sec)

mysql> INSERT INTO CUSTOMER(CustomerID,CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
    -> VALUES(1,'Janine Jeffers', '152 Lomb Memorial Dr.', 'Rochester', 'NY', '14623', 'jxj1234@rit.edu','h');
--------------
INSERT INTO CUSTOMER(CustomerID,CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
VALUES(1,'Janine Jeffers', '152 Lomb Memorial Dr.', 'Rochester', 'NY', '14623', 'jxj1234@rit.edu','h')
--------------

Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO CUSTOMER(CustomerID,CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
    -> VALUES(2,'Janine John', '152 Lomb Avenue Dr.', 'Avenue', 'NY', '82269', 'adsa@rit.edu','o');
--------------
INSERT INTO CUSTOMER(CustomerID,CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
VALUES(2,'Janine John', '152 Lomb Avenue Dr.', 'Avenue', 'NY', '82269', 'adsa@rit.edu','o')
--------------

ERROR 1265 (01000): Data truncated for column 'bussiness_or_home' at row 1
mysql> 
mysql> select * from HOME;
--------------
select * from HOME
--------------

Empty set (0.00 sec)

mysql> INSERT INTO HOME VALUES (1,'1234567890123456', '012014');
--------------
INSERT INTO HOME VALUES (1,'1234567890123456', '012014')
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> UPDATE Customer
    -> SET bussiness_or_home = 'h'
    -> WHERE EMAIL = 'jxj1234@rit.edu';
--------------
UPDATE Customer
SET bussiness_or_home = 'h'
WHERE EMAIL = 'jxj1234@rit.edu'
--------------

Query OK, 0 rows affected (0.01 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql> 
mysql> select * from ORDERED;
--------------
select * from ORDERED
--------------

Empty set (0.00 sec)

mysql> INSERT INTO ORDERED VALUES (1, '113.74',1);
--------------
INSERT INTO ORDERED VALUES (1, '113.74',1)
--------------

Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO ORDERED VALUES (2, '113.74',2);
--------------
INSERT INTO ORDERED VALUES (2, '113.74',2)
--------------

ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`kiros_acmeonline`.`ordered`, CONSTRAINT `ordered_CustomerID_fk` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER` (`CustomerID`))
mysql> 
mysql> select * from CUSTOMER;
--------------
select * from CUSTOMER
--------------

+------------+----------------+-----------------------+-----------------+-------------------+-----------+-------+---------+
| CustomerID | CustomerName   | Address               | Email           | bussiness_or_home | City      | State | Zipcode |
+------------+----------------+-----------------------+-----------------+-------------------+-----------+-------+---------+
|          1 | Janine Jeffers | 152 Lomb Memorial Dr. | jxj1234@rit.edu | h                 | Rochester | NY    | 14623   |
+------------+----------------+-----------------------+-----------------+-------------------+-----------+-------+---------+
1 row in set (0.00 sec)

mysql> select * from LINE_ITEM;
--------------
select * from LINE_ITEM
--------------

Empty set (0.00 sec)

mysql> SELECT *
    -> FROM ITEM;
--------------
SELECT *
FROM ITEM
--------------

+-------------+--------------------+-------------------------+-----------+-------+
| Item_Number | Item_Name          | Description             | Model     | Price |
+-------------+--------------------+-------------------------+-----------+-------+
|           1 | Cabbage Patch Doll | Baby boy doll           | Boy       | 39.95 |
|           2 | The Last Lecture   | Written by Randy Pausch | Hardcover | 9.95  |
+-------------+--------------------+-------------------------+-----------+-------+
2 rows in set (0.00 sec)

mysql> select * from ORDERED;
--------------
select * from ORDERED
--------------

+---------+------------+------------+
| OrderID | total_cost | CustomerID |
+---------+------------+------------+
|       1 | 113.74     |          1 |
+---------+------------+------------+
1 row in set (0.00 sec)

mysql> INSERT INTO LINE_ITEM VALUES(1, 1, 2);
--------------
INSERT INTO LINE_ITEM VALUES(1, 1, 2)
--------------

Query OK, 1 row affected (0.00 sec)

mysql> 
mysql> INSERT INTO LINE_ITEM VALUES(2, 2, 3);
--------------
INSERT INTO LINE_ITEM VALUES(2, 2, 3)
--------------