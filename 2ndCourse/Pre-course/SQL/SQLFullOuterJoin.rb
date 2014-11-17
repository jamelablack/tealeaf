
SQL FULL OUTER JOIN Keyword
	The FULL OUTER JOIN keyword returns all rows from the left table (table1) and from the right table (table2).

	The FULL OUTER JOIN keyword combines the result of both LEFT and RIGHT joins.

	SQL FULL OUTER JOIN Syntax

	SELECT column_name(s)
	FROM table1
	FULL OUTER JOIN table2
	ON table1.column_name=table2.column_name;


SQL FULL OUTER JOIN Example
	The following SQL statement selects all customers, and all orders:

	SELECT Customers.CustomerName, Orders.OrderID
	FROM Customers
	FULL OUTER JOIN Orders
	ON Customers.CustomerID=Orders.CustomerID
	ORDER BY Customers.CustomerName;