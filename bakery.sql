-- Створення таблиці клієнтів
CREATE TABLE Customers (
    ID_Customer bigint PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Phone varchar(15)
);

-- Створення таблиці працівників
CREATE TABLE Employees (
    ID_Employee bigint PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Position varchar(50),
    Salary decimal(10,2)
);

-- Створення таблиці продуктів/випічки
CREATE TABLE Products (
    ID_Product bigint PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Price decimal(10,2) NOT NULL,
    Category varchar(50)
);

-- Створення таблиці інгредієнтів
CREATE TABLE Ingredients (
    ID_Ingredient bigint PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Unit_Price decimal(10,2)
);

-- Створення таблиці постачальників
CREATE TABLE Suppliers (
    ID_Supplier bigint PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Contact_Details varchar(200),
    Address text
);

-- Створення таблиці замовлень
CREATE TABLE Orders (
    ID_Order bigint PRIMARY KEY,
    Order_Date datetime NOT NULL,
    Total_Amount decimal(10,2),
    ID_Customer bigint,
    FOREIGN KEY (ID_Customer) REFERENCES Customers(ID_Customer)
);

-- Створення таблиці деталей замовлення
CREATE TABLE Order_Details (
    ID_Order bigint,
    ID_Product bigint,
    Quantity int NOT NULL,
    Price decimal(10,2) NOT NULL,
    PRIMARY KEY (ID_Order, ID_Product),
    FOREIGN KEY (ID_Order) REFERENCES Orders(ID_Order),
    FOREIGN KEY (ID_Product) REFERENCES Products(ID_Product)
);

-- Створення таблиці зв'язку продуктів та інгредієнтів
CREATE TABLE Product_Ingredient (
    ID_Product bigint,
    ID_Ingredient bigint,
    Quantity decimal(10,3) NOT NULL,
    PRIMARY KEY (ID_Product, ID_Ingredient),
    FOREIGN KEY (ID_Product) REFERENCES Products(ID_Product),
    FOREIGN KEY (ID_Ingredient) REFERENCES Ingredients(ID_Ingredient)
);

-- Створення таблиці поставок інгредієнтів
CREATE TABLE Supplier_Ingredient (
    ID_Supplier bigint,
    ID_Ingredient bigint,
    Supply_Date date,
    Price decimal(10,2) NOT NULL,
    PRIMARY KEY (ID_Supplier, ID_Ingredient),
    FOREIGN KEY (ID_Supplier) REFERENCES Suppliers(ID_Supplier),
    FOREIGN KEY (ID_Ingredient) REFERENCES Ingredients(ID_Ingredient)
);

-- Створення таблиці транзакцій
CREATE TABLE Transactions (
    ID_Transaction bigint PRIMARY KEY,
    ID_Order bigint,
    Payment_Method varchar(50) NOT NULL,
    Transaction_Date datetime NOT NULL,
    Amount decimal(10,2) NOT NULL,
    FOREIGN KEY (ID_Order) REFERENCES Orders(ID_Order)
);

-- Додавання клієнтів
INSERT INTO Customers VALUES
(1, 'Іван Петров', '+380501234567'),
(2, 'Марія Коваль', '+380672345678'),
(3, 'Олег Сидоренко', '+380633456789'),
(4, 'Анна Мельник', '+380994567890'),
(5, 'Павло Шевченко', '+380505678901');

-- Додавання працівників
INSERT INTO Employees VALUES 
(1, 'Ольга Іванова', 'Пекар', 15000.00),
(2, 'Микола Петренко', 'Кондитер', 18000.00),
(3, 'Світлана Ковальчук', 'Продавець', 12000.00),
(4, 'Андрій Білик', 'Пекар', 15000.00),
(5, 'Тетяна Лисенко', 'Менеджер', 20000.00);

-- Вивести всіх працівників з зарплатою більше 15000
SELECT Name, Position, Salary 
FROM Employees 
WHERE Salary > 15000;

-- Порахувати середню зарплату по посадах
SELECT Position, AVG(Salary) as AvgSalary
FROM Employees
GROUP BY Position;

-- Вивести клієнтів в алфавітному порядку
SELECT * FROM Customers 
ORDER BY Name;

-- Вивести посади, де середня зарплата більше 15000
SELECT Position, AVG(Salary) as AvgSalary
FROM Employees
GROUP BY Position
HAVING AVG(Salary) > 15000;

-- Підзапити
-- Знайти працівників із зарплатою вище середньої
SELECT Name, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Використання IN
-- Знайти всіх працівників, які працюють пекарями або кондитерами
SELECT Name, Position
FROM Employees
WHERE Position IN ('Пекар', 'Кондитер');

-- Використання EXISTS
-- Знайти клієнтів, які робили замовлення
SELECT Name
FROM Customers c
WHERE EXISTS (
   SELECT 1 
   FROM Orders o 
   WHERE o.ID_Customer = c.ID_Customer
);

-- Використання ANY
-- Знайти працівників, чия зарплата більша за будь-яку зарплату продавців
SELECT Name, Salary
FROM Employees
WHERE Salary > ANY (
   SELECT Salary 
   FROM Employees 
   WHERE Position = 'Продавець'
);

-- Використання ALL
-- Знайти працівників, чия зарплата більша за всі зарплати продавців
SELECT Name, Salary
FROM Employees
WHERE Salary > ALL (
   SELECT Salary 
   FROM Employees 
   WHERE Position = 'Продавець'
);

-- Маніпулювання даними
-- INSERT
INSERT INTO Employees (ID_Employee, Name, Position, Salary)
VALUES (6, 'Василь Коваленко', 'Пекар', 16000.00);

-- UPDATE
UPDATE Employees
SET Salary = Salary * 1.1
WHERE Position = 'Пекар';

-- DELETE
DELETE FROM Employees
WHERE ID_Employee = 6;

-- Операції над схемою бази даних
-- Створення бази даних
-- CREATE DATABASE Bakery;

-- Створення таблиці (приклад)
CREATE TABLE TestTable (
   ID bigint PRIMARY KEY,
   Name varchar(100)
);

-- Видалення таблиці
-- DROP TABLE TestTable;

-- Видалення бази даних
-- DROP DATABASE Bakery;