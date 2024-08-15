create database bank;

-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    cust_id INT PRIMARY KEY,
    NIC VARCHAR(20),
    name VARCHAR(255),
    address VARCHAR(255),
    DOB DATE,
    phoneNo VARCHAR(15),
    email VARCHAR(255)
);

-- Create BANK table
CREATE TABLE BANK (
    bank_code INT PRIMARY KEY,
    address VARCHAR(255),
    bank_name VARCHAR(255),
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id)
);

-- Create PASSBOOK table
CREATE TABLE PASSBOOK (
    passbook_id INT PRIMARY KEY
);

-- Create TRANSACTION table
CREATE TABLE TRANSACTION (
    transactionId INT PRIMARY KEY,
    deposit DECIMAL(15, 2),
    withdrawal DECIMAL(15, 2),
    description VARCHAR(255),
    amount DECIMAL(15, 2),
    date DATE,
    time TIME,
    cust_id INT,
    passbook_id INT,
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id),
    FOREIGN KEY (passbook_id) REFERENCES PASSBOOK(passbook_id)
);

-- Create ACCOUNT table
CREATE TABLE ACCOUNT (
    accNo INT PRIMARY KEY,
    accType VARCHAR(50),
    balAmount DECIMAL(15, 2),
    cust_id INT,
    passbook_id INT,
    bank_code INT,
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id),
    FOREIGN KEY (passbook_id) REFERENCES PASSBOOK(passbook_id),
    FOREIGN KEY (bank_code) REFERENCES BANK(bank_code)
);

-- Create ATM_CARD table
CREATE TABLE ATM_CARD (
    cardNo INT PRIMARY KEY,
    expDate DATE,
    CVV_no INT,
    accNo INT,
    FOREIGN KEY (accNo) REFERENCES ACCOUNT(accNo)
);

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'BANK' AND COLUMN_NAME = 'cust_id'
AND REFERENCED_TABLE_NAME = 'CUSTOMER';

ALTER TABLE BANK
DROP FOREIGN KEY bank_ibfk_1;

ALTER TABLE BANK
DROP COLUMN cust_id;

INSERT INTO BANK (bank_code, address, bank_name)
VALUES
(101, '456/7, Main Street, Colombo', 'Lanka Bank - Colombo'),
(102, '789/8, Queen’s Road, Kandy', 'Lanka Bank - Kandy'),
(103, '101/9, High Street, Galle', 'Lanka Bank - Galle'),
(104, '123/4, Temple Road, Maharagama', 'Lanka Bank - Maharagama');

INSERT INTO CUSTOMER (cust_id, NIC, name, address, DOB, phoneNo, email) VALUES
(1001, '2000123451', 'Sunil Fernando', '415/3, 1st cross street , Galle, Sri Lanka', '1985-03-10', '+94232223344', 'sunil.fernando@example.com'),
(1002, '2000987652', 'Chandani Weerasinghe', '23/B, Matara, Sri Lanka', '1992-12-05', '+94232223355', 'chandani.weerasinghe@example.com'),
(1003, '2000112233', 'Anil Kumara', '12/A,flower road , Colombo 05, Sri Lanka', '1978-08-22', '+94221223366', 'anil.kumara@example.com'),
(1004, '2000556679', 'Rukmani Rajapaksa', 'Colombo 2, Sri Lanka', '1989-11-30', '+94112223377', 'rukmani.rajapaksa@example.com'),
(1005, '2000998876', 'Niranjan Jayasinghe', '145, Negombo, Sri Lanka', '1982-06-15', '+94112223388', 'niranjan.jayasinghe@example.com'),
(1006, '9A234567v', 'Priya Dissanayake', '4B, Bhodi street , Kalutara, Sri Lanka', '1995-09-10', '+94222223399', 'priya.dissanayake@example.com'),
(1007, '9B345678v', 'Malith Perera', '23, hawlock road, Ratnapura, Sri Lanka', '1987-04-25', '+94223334400', 'malith.perera@example.com'),
(1008, '9C456789v', 'Sanduni Perera', '08, Anuradhapura, Sri Lanka', '1994-02-20', '+94224455611', 'sanduni.perera@example.com'),
(1009, '9D567890v', 'Kasun Wijesinghe', '12/B, 2nd cross road, Kegalle, Sri Lanka', '1983-12-30', '+94225566722', 'kasun.wijesinghe@example.com'),
(1010, '9E678901v', 'Samanthi Senanayake', '12, Makola north, Makola , Sri Lanka', '1991-07-16', '+94226677833', 'samanthi.senanayake@example.com');


-- Insert into PASSBOOK
INSERT INTO PASSBOOK (passbook_id) VALUES
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);

INSERT INTO ACCOUNT (accNo, accType, balAmount, cust_id, passbook_id, bank_code) VALUES
(1003, 'Savings', 60000.00, 1001, 3, 103),
(1004, 'Current', 200000.00, 1002, 4, 103),
(1005, 'Savings', 75000.00, 1003, 5, 103),
(1006, 'Current', 100000.00, 1004, 6, 103),
(1007, 'Savings', 30000.00, 1005, 7, 103),
(1008, 'Current', 80000.00, 1006, 8, 103),
(1009, 'Savings', 45000.00, 1007, 9, 103);

INSERT INTO ACCOUNT (accNo, accType, balAmount, cust_id, passbook_id, bank_code) VALUES
(1010, 'Current', 120000.00, 1008, 10, 103),
(1011, 'Savings', 55000.00, 1009, 11, 103),
(1012, 'Current', 95000.00, 1010, 12, 103);

-- Insert into TRANSACTION
INSERT INTO TRANSACTION (transactionId, deposit, withdrawal, description, amount, date, time, cust_id, passbook_id) VALUES
(3, 15000.00, 0.00, 'Bonus deposit', 15000.00, '2024-08-01', '11:00:00', 1001, 3),
(4, 0.00, 10000.00, 'ATM withdrawal', 10000.00, '2024-08-03', '16:00:00', 1002, 4),
(5, 20000.00, 0.00, 'Monthly deposit', 20000.00, '2024-08-05', '09:00:00', 1003, 5),
(6, 0.00, 5000.00, 'ATM withdrawal', 5000.00, '2024-08-06', '13:00:00', 1004, 6),
(7, 5000.00, 0.00, 'Cash deposit', 5000.00, '2024-08-07', '10:00:00', 1005, 7),
(8, 0.00, 12000.00, 'ATM withdrawal', 12000.00, '2024-08-08', '15:00:00', 1006, 8),
(9, 10000.00, 0.00, 'Transfer deposit', 10000.00, '2024-08-09', '12:00:00', 1007, 9),
(10, 0.00, 20000.00, 'ATM withdrawal', 20000.00, '2024-08-10', '17:00:00', 1008, 10),
(11, 7000.00, 0.00, 'Savings deposit', 7000.00, '2024-08-11', '11:30:00', 1009, 11),
(12, 0.00, 15000.00, 'ATM withdrawal', 15000.00, '2024-08-12', '14:00:00', 1010, 12);


-- Insert into ATM_CARD with adjusted card numbers
INSERT INTO ATM_CARD (cardNo, expDate, CVV_no, accNo) VALUES
(123456789, '2026-12-31', 789, 1003),
(234567890, '2025-11-30', 890, 1004),
(345678901, '2026-10-31', 901, 1005),
(456789012, '2024-09-30', 123, 1006),
(567890123, '2025-08-31', 234, 1007),
(678901234, '2026-07-31', 345, 1008),
(789012345, '2025-06-30', 456, 1009),
(890123456, '2024-05-31', 567, 1010),
(901234567, '2026-04-30', 678, 1011),
(123456709, '2025-03-31', 789, 1012);


SHOW TABLES;

DESCRIBE table_name;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
SELECT * FROM BANK;

