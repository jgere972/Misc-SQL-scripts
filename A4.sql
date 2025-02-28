--COMP2521-001
--Assignment 4
--Joseph G.

--Queries

--1a
SELECT customerName, phone
FROM customers C, orders O
WHERE C.customerNumber = O.customerNumber
GROUP BY C.customerNumber
HAVING COUNT(orderNumber) > 10;

--1b
SELECT customerName, phone
FROM customers 
WHERE customerNumber IN (SELECT customerNumber
FROM orders
GROUP BY customerNumber
HAVING COUNT(orderNumber) > 10);

--2
SELECT customerName, status AS Order_status, Max(orderDate) As Recent_order_dates
FROM customers C INNER JOIN orders O USING(customerNumber)
GROUP BY O.customerNumber
HAVING MAX(orderDate) = (SELECT MAX(orderDate)
FROM orders
HAVING MAX(orderDate));

--3a
SELECT C.customerNumber, customerName, COUNT(orderNumber) AS OrderCount
FROM customers C LEFT OUTER JOIN orders O ON C.customerNumber = O.customerNumber
GROUP BY C.customerNumber
HAVING COUNT(orderNumber) = 0;

--3b
SELECT customerNumber, customerName, 'No Order Placed' AS OrderCount
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber
FROM orders
GROUP BY customerNumber
HAVING COUNT(orderNumber) > 0);

--4a
SELECT Employee.lastName AS Employee, Manager.lastName AS Manager
FROM employees Employee LEFT OUTER JOIN employees Manager ON Employee.reportsTo = Manager.employeeNumber;

--4b
SELECT Employee.lastName AS Employee,
(SELECT Manager.lastName
FROM employees Manager
WHERE Manager.employeeNumber = Employee.reportsTo) AS Manager
FROM employees Employee;

--5
SELECT Manager.lastName AS Manager_lastName, Manager.firstName AS Manager_firstName, COUNT(Manager.employeeNumber) AS Reportings
FROM employees Employee, employees Manager
WHERE Employee.reportsTo = Manager.employeeNumber
GROUP BY Manager.lastName, Manager.firstName;
