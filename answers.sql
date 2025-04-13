-- CREATE DATABASE assignment_trial;
CREATE DATABASE bookstore;

USE bookstore;

-- Table for storing authors
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Table for storing book languages
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(255) NOT NULL
    );

-- Table for storing publishers
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Table for storing customers
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Table for storing address statuses
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255) NOT NULL
);

-- Table for storing countries
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL
);

-- Table for storing books
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Table for many-to-many relationship between books and authors
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Table for storing addresses
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Table for storing customer orders
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Table for storing order details
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Table for storing customer addresses
CREATE TABLE customer_address (
    address_id INT,
    customer_id INT,
    status_id INT,
    PRIMARY KEY (address_id, customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Create Shipping Methods Table
CREATE TABLE ShippingMethod (
    MethodID INT PRIMARY KEY,
    MethodName VARCHAR(50)
);

-- Create Order History Table
CREATE TABLE OrderHistory (
    HistoryID INT PRIMARY KEY,
    OrderID INT,
    Status VARCHAR(50),
    Timestamp DATETIME
);

-- Create Order Status Table
CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY,
    StatusName VARCHAR(50)
);

-- Create Orders Table (Linking everything together)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ShippingMethodID INT,
    CurrentStatusID INT,
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethod(MethodID),
    FOREIGN KEY (CurrentStatusID) REFERENCES OrderStatus(StatusID)
);

-- creating users
CREATE USER "brian"@"localhost"
IDENTIFIED BY "1234";
CREATE USER "alfonce"@"localhost"
IDENTIFIED BY "1234";
CREATE USER "siwa"@"localhost"
IDENTIFIED BY "1234";

-- create roles
CREATE ROLE administrator,supervisor,cashier;

-- Assign permissions to roles
GRANT ALL ON bookstore.* TO admins;
GRANT INSERT, UPDATE, DELETE, SELECT ON bookstore.* TO supervisor;
GRANT SELECT ON bookstore.* TO cashier;

-- Assign roles to users
GRANT administrator TO alfonce@localhost;
GRANT supervisor TO siwa@localhost;
GRANT cashier TO brian@localhost;


-- POPULATING THE TABLES

-- Insert data into the book table
INSERT INTO book (title, isbn) VALUES
    ('The Great Gatsby', '97807'),
    ('To Kill a Mockingbird', '97800'),
    ('1984', '9780451524935'),
    ('Pride and Prejudice', '9780141439518'),
    ('The Catcher in the Rye', '9780316769488'),
    ('The Hobbit', '9780547928227'),
    ('Fahrenheit 451', '9781451673319'),
    ('Jane Eyre', '9780141441146'),
    ('Animal Farm', '9780451526342'),
    ('The Lord of the Rings', '9780544003415'),
    ('Moby Dick', '9781503280786'),
    ('War and Peace', '9780199232765'),
    ('Crime and Punishment', '9780140449136'),
    ('The Odyssey', '9780140268867'),
    ('The Iliad', '9780140275360'),
    ('Brave New World', '9780060850524'),
    ('Wuthering Heights', '9780141439556'),
    ('The Divine Comedy', '9780140448955'),
    ('Les Misérables', '9780451419439'),
    ('Don Quixote', '9780060934347');


-- Insert data into the book_language table
INSERT INTO book_language (language_name) VALUES
('english');

-- updating language_id on the book table
UPDATE book
SET 
	language_id = 1
WHERE
	book_id = 10;

-- Insert data into the publisher table
INSERT INTO publisher (name) VALUES
    ('Penguin Random House'),
    ('HarperCollins'),
    ('Simon & Schuster'),
    ('Hachette Book Group'),
    ('Macmillan Publishers'),
    ('Scholastic Corporation'),
    ('Pearson Education'),
    ('Oxford University Press'),
    ('Cambridge University Press'),
    ('Wiley');


-- updating publisher_id on the book table
UPDATE book
SET 
	publisher_id = 6
WHERE
	book_id = 1;

--QUERRYING THE DATABASE, RETRIEVING AND ANALYZING DATA

-- displaying book titles based on the publishe_id
SELECT title
FROM book
WHERE publisher_id=6
ORDER BY book_id ASC LIMIT 3;