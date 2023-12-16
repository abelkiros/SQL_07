
DROP DATABASE kiros_ACMEOnline;
CREATE DATABASE kiros_ACMEOnline;

USE kiros_ACMEOnline;

CREATE TABLE ITEM
(
    Item_Number INT
    UNSIGNED AUTO_INCREMENT, 
    Item_Name VARCHAR(35) NOT NULL,
    Description VARCHAR(255),
    Model VARCHAR(50) NOT NULL,
    Price VARCHAR(9) NOT NULL,
    CONSTRAINT item_pk PRIMARY KEY (Item_Number)
);

DESCRIBE ITEM;

CREATE TABLE CUSTOMER
(
    CustomerID INT
    UNSIGNED NOT NULL AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    Address VARCHAR(150) NOT NULL,
    Email VARCHAR(80),
    bussiness_or_home ENUM ('b', 'h'),
    CONSTRAINT customer_pk PRIMARY KEY(CustomerID)
);


DESCRIBE CUSTOMER;

CREATE TABLE ORDERED
(
    OrderID INT
    UNSIGNED AUTO_INCREMENT, /*fK */
    total_cost VARCHAR(11),
    CustomerID INT UNSIGNED NOT NULL, /*fK */
    CONSTRAINT ordered_pk PRIMARY KEY(OrderID),
    CONSTRAINT ordered_CustomerID_fk FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
);

DESCRIBE ORDERED;

CREATE TABLE LINE_ITEM
(
    OrderID INT
    UNSIGNED NOT NULL ,
    Item_Number INT UNSIGNED NOT NULL, 
    quantity TINYINT(255) NOT NULL,
    CONSTRAINT line_item_pk PRIMARY KEY(Item_Number, OrderID),
    CONSTRAINT line_item_fk FOREIGN KEY(Item_Number) REFERENCES ITEM(Item_Number),
    CONSTRAINT line_item_orderID_fk FOREIGN KEY(OrderID) REFERENCES ORDERED(OrderID)
);

DESCRIBE LINE_ITEM;

CREATE TABLE HOME
(
    CustomerID INT
    UNSIGNED NOT NULL,
    CreditCardNum char(16) NOT NULL,
    CreditCardExpirationDate char(6) NOT NULL,
    CONSTRAINT home_pk PRIMARY KEY(CustomerID , CreditCardNum),
    CONSTRAINT home_customer_fk FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
);

DESCRIBE HOME;

CREATE TABLE BUSINESS
(
    CustomerID INT UNSIGNED NOT NULL,
    PaymentTerms VARCHAR(50) NOT NULL,
    CONSTRAINT business_pk PRIMARY KEY(CustomerID,PaymentTerms),
    CONSTRAINT business_customer_fk FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

DESCRIBE BUSINESS;

INSERT INTO ITEM(Item_Name, Description, Model, Price) VALUES ('Cabbage Patch Doll', 'Baby boy doll', 'Boy', '39.95');

INSERT INTO ITEM(Item_Name, Description, Model, Price) VALUES ('The Last Lecture','', 'Hardcover', '9.95');

INSERT INTO ITEM (Item_Name, Description, Model, Price) VALUES ('Keurig Beverage Maker', 'Keurig Platinum Edition Beverage Maker in Red', 'Platinum Edition', '299.95');

SELECT *
FROM ITEM;

ALTER TABLE CUSTOMER 
MODIFY COLUMN Address VARCHAR(100);

ALTER TABLE CUSTOMER 
ADD COLUMN City VARCHAR(60);

ALTER TABLE CUSTOMER
ADD COLUMN State CHAR(2);

ALTER TABLE CUSTOMER
ADD COLUMN Zipcode decimal(5,4);

ALTER TABLE CUSTOMER
DROP COLUMN Zipcode;

ALTER TABLE CUSTOMER
ADD COLUMN Zipcode varchar(5);

DELETE FROM ITEM
WHERE Item_Name = 'Keurig Beverage Maker' and item_number = 3;

UPDATE ITEM
SET Description = 'Written by Randy Pausch'
WHERE Description = '';

select * from CUSTOMER;
INSERT INTO CUSTOMER(CustomerName,Address,CITY,STATE,ZipCode,EMAIL,bussiness_or_home) 
VALUES('Janine Jeffers', '152 Lomb Memorial Dr.', 'Rochester', 'NY', '14623', 'jxj1234@rit.edu','h');

select * from HOME;
INSERT INTO HOME VALUES (1,'1234567890123456', '012014');

UPDATE Customer
SET bussiness_or_home = 'h'
WHERE EMAIL = 'jxj1234@rit.edu';

select * from ORDERED;
INSERT INTO ORDERED VALUES (1, '113.74',1);

select * from LINE_ITEM;
INSERT INTO LINE_ITEM VALUES(1, 1, 2);
INSERT INTO LINE_ITEM VALUES(2, 1, 3);