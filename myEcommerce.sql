CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

INSERT INTO Customers (name,email,phone,address) VALUES
('Rahul Sharma','rahul1@gmail.com','9876543210','Delhi'),
('Priya Singh','priya2@gmail.com','9123456789','Mumbai'),
('Amit Verma','amit3@gmail.com','9988776655','Kolkata'),
('Neha Gupta','neha4@gmail.com','9876501234','Chennai'),
('Vikram Patel','vikram5@gmail.com','9786543210','Ahmedabad'),
('Sneha Reddy','sneha6@gmail.com','9678451230','Hyderabad'),
('Rohit Mehta','rohit7@gmail.com','9456123789','Pune'),
('Anjali Das','anjali8@gmail.com','9345678123','Bangalore'),
('Sanjay Yadav','sanjay9@gmail.com','9567894321','Jaipur'),
('Meera Iyer','meera10@gmail.com','9876123450','Chandigarh'),
('Arjun Nair','arjun11@gmail.com','9789012345','Kerala'),
('Kiran Kumar','kiran12@gmail.com','9123004567','Lucknow'),
('Ramesh Choudhary','ramesh13@gmail.com','9912345678','Patna'),
('Sunita Mishra','sunita14@gmail.com','9988001122','Bhopal'),
('Deepak Sahu','deepak15@gmail.com','9898765432','Nagpur'),
('Pooja Malhotra','pooja16@gmail.com','9765432109','Surat'),
('Vivek Singh','vivek17@gmail.com','9654321780','Kanpur'),
('Shruti Jain','shruti18@gmail.com','9123456701','Indore'),
('Manish Agarwal','manish19@gmail.com','9345678091','Ranchi'),
('Kavita Thakur','kavita20@gmail.com','9876543001','Raipur');

-- 2. PRODUCTS
CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO Products (product_name, category, price, stock) VALUES
('Laptop','Electronics',50000,10),
('Mobile Phone','Electronics',15000,25),
('Shoes','Fashion',2000,50),
('Bag','Fashion',1200,30),
('Jacket','Fashion',2500,20);

-- 3. ORDERS
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 20 Orders, one per customer
INSERT INTO Orders (customer_id, order_date) VALUES
(1,'2025-09-01'),(2,'2025-09-02'),(3,'2025-09-03'),(4,'2025-09-04'),(5,'2025-09-05'),
(6,'2025-09-06'),(7,'2025-09-07'),(8,'2025-09-08'),(9,'2025-09-09'),(10,'2025-09-10'),
(11,'2025-09-11'),(12,'2025-09-12'),(13,'2025-09-13'),(14,'2025-09-14'),(15,'2025-09-15'),
(16,'2025-09-16'),(17,'2025-09-17'),(18,'2025-09-18'),(19,'2025-09-19'),(20,'2025-09-20');

-- 4. ORDERDETAILS
CREATE TABLE IF NOT EXISTS OrderDetails (
    orderdetail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Random products for each order
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1,1,1),(1,4,1),
(2,2,2),(2,3,1),
(3,1,1),(3,2,1),
(4,3,2),(4,4,1),
(5,1,1),(5,5,1),
(6,2,1),(6,4,1),
(7,3,1),(7,5,2),
(8,1,1),(8,2,1),
(9,4,2),(9,5,1),
(10,1,1),(10,3,1),
(11,2,1),(11,5,1),
(12,3,1),(12,4,1),
(13,1,1),(13,2,1),
(14,4,1),(14,5,1),
(15,1,1),(15,3,1),
(16,2,2),(16,5,1),
(17,1,1),(17,4,1),
(18,2,1),(18,3,1),
(19,3,1),(19,5,1),
(20,1,1),(20,4,1);

-- 5. PAYMENTS
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Payments for each order
INSERT INTO Payments (order_id,payment_date,amount,payment_method) VALUES
(1,'2025-09-01',6200,'Credit Card'),
(2,'2025-09-02',4600,'UPI'),
(3,'2025-09-03',8500,'Debit Card'),
(4,'2025-09-04',3200,'Cash'),
(5,'2025-09-05',4200,'Net Banking'),
(6,'2025-09-06',7000,'UPI'),
(7,'2025-09-07',5100,'Credit Card'),
(8,'2025-09-08',3500,'Debit Card'),
(9,'2025-09-09',6200,'UPI'),
(10,'2025-09-10',2700,'Cash'),
(11,'2025-09-11',5000,'Net Banking'),
(12,'2025-09-12',6500,'UPI'),
(13,'2025-09-13',8000,'Debit Card'),
(14,'2025-09-14',3700,'Credit Card'),
(15,'2025-09-15',4500,'UPI'),
(16,'2025-09-16',6900,'Debit Card'),
(17,'2025-09-17',5100,'Credit Card'),
(18,'2025-09-18',3400,'UPI'),
(19,'2025-09-19',7200,'Debit Card'),
(20,'2025-09-20',4300,'Cash');

-- 6. FINAL JOIN QUERY (Clean, one row per order)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.email,
    c.phone,
    c.address,
    o.order_id,
    o.order_date,
    GROUP_CONCAT(p.product_name SEPARATOR ', ') AS products_ordered,
    SUM(od.quantity) AS total_quantity,
    SUM(pay.amount) AS total_payment,
    GROUP_CONCAT(pay.payment_method SEPARATOR ', ') AS payment_methods
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN Payments pay ON o.order_id = pay.order_id
GROUP BY o.order_id
ORDER BY o.order_id;
