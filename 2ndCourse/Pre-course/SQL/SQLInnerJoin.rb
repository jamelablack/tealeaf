SQL JOIN
An SQL JOIN clause is used to combine rows from two or more tables, based on a common field between them.

The most common type of join is: SQL INNER JOIN (simple join). 
An SQL INNER JOIN return all rows from multiple tables where the join condition is met.

Notice that the "CustomerID" column in the "Orders" table refers to the "CustomerID" in the "Customers" table. The relationship between the two tables above is the "CustomerID" column.

Then, if we run the following SQL statement (that contains an INNER JOIN):

Example

SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID=Customers.CustomerID;


Different SQL JOINs
Before we continue with examples, we will list the types the different SQL JOINs you can use:

INNER JOIN: Returns all rows when there is at least one match in BOTH tables
LEFT JOIN: Return all rows from the left table, and the matched rows from the right table
RIGHT JOIN: Return all rows from the right table, and the matched rows from the left table
FULL JOIN: Return all rows when there is a match in ONE of the tables


SQL INNER JOIN Example
The following SQL statement will return all customers with orders:

Example

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;