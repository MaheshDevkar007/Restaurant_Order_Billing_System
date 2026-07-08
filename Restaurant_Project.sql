Create Database Restaurant;
use Restaurant;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE Menu (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(8,2) NOT NULL
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(30),
    amount DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
INSERT INTO Customers
(customer_name,phone,city)
values 
('Rahul Patil','9876543210','Pune'),
('sneha Joshi', '9988776655', 'Mumbai'),
('Amit Patil',  '9911223344', 'Nashik'),
('janhavi Patil','9080706050','Latur'),
('Mahesh Devkar','7620267007','Dharashiv');

INSERT INTO Menu (item_name, category, price)
 VALUES
('Veg Burger', 'Fast Food', 120.00),
('Paneer Pizza', 'Pizza', 280.00),
('Masala Dosa', 'South Indian', 90.00),
('Cold Coffee', 'Beverage', 110.00),
('Chocolate Brownie', 'Dessert', 150.00),
('Veg Biryani', 'Main Course', 220.00),
('French Fries', 'Snacks', 100.00),
('Mango Shake', 'Beverage', 130.00);

INSERT INTO Orders (customer_id, order_date)
 VALUES
(1, '2026-07-01'),
(2, '2026-07-02'),
(3, '2026-07-03'),
(4, '2026-07-04'),
(5, '2026-07-05');

INSERT INTO Order_Items (order_id, item_id, quantity) 
VALUES
(1, 1, 2),
(1, 4, 1),
(2, 2, 1),
(2, 5, 2),
(3, 3, 2),
(4, 6, 1),
(4, 7, 2),
(5, 8, 2);
INSERT INTO Payments (order_id, payment_method, amount) VALUES
(1, 'UPI', 350.00),
(2, 'Card', 580.00),
(3, 'Cash', 180.00),
(4, 'UPI', 420.00),
(5, 'Cash', 260.00);

SELECT * FROM Customers;
SELECT* FROM Menu;
SELECT *FROM customers
WHERE city = 'Pune';

SELECT*FROM Customers
Where city = 'Dharashiv';
SELECT* FROM Menu
order by price DESC;

SELECT* FROM Menu
order by price asc;

SELECT
    c.customer_name,
    o.order_id,
    o.order_date
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

SELECT
    c.customer_name,
    o.order_date,
    p.payment_method,
    p.amount
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Payments p
    ON o.order_id = p.order_id;
    
    SELECT
    c.customer_name,
    SUM(p.amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_name;

SELECT
    c.customer_name,
    SUM(p.amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_name
HAVING SUM(p.amount) > 300;

CREATE VIEW Customer_Payment_Summary AS
SELECT
    c.customer_name,
    o.order_date,
    p.payment_method,
    p.amount
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Payments p
    ON o.order_id = p.order_id;
    
    SELECT *FROM Customer_Payment_Summary;
    
   
   UPDATE Menu
    set price =140
    WHERE item_name = 'veg Burger';
    
    SELECT * FROM Menu;
    delete from Menu 
    where item_id = 8;
    
    Insert into Customers 
    ( customer_name, phone, city)
    Values ('test user' , '9999999999', 'bhum');
    
    delete from Customers Where customer_name = 'test user';
    select *from Customers ;
    
    SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

SELECT count(*) as
Total_customers
from Customers;

select avg(Price)
 As Average_Price
 from Menu;
 
 SELECT
MAX(price) AS Highest_Price,
MIN(price) AS Lowest_Price
FROM Menu;

SELECT
    item_name,
    price,
    CASE
        WHEN price >= 200 THEN 'Expensive'
        WHEN price >= 100 THEN 'Medium'
        ELSE 'Budget'
    END AS Price_Category
FROM Menu;

SELECT item_name, price
FROM Menu
WHERE price > (
    SELECT AVG(price)
    FROM Menu); 
    
    SELECT
    c.customer_name,
    o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id

UNION

SELECT
    c.customer_name,
    o.order_id
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;

CREATE INDEX idx_customer_name
ON Customers(customer_name);

DELIMITER $$

CREATE PROCEDURE GetMenuItems()
BEGIN
    SELECT * FROM Menu;
END $$

DELIMITER ;
CALL GetMenuItems();

   
   
    
    


