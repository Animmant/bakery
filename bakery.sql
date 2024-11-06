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