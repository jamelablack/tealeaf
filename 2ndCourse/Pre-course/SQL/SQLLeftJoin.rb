SQL LEFT JOIN Keyword
		The LEFT JOIN keyword returns all rows from the left table (table1), with the matching rows in the right table (table2). The result is NULL in the right side when there is no match.

		SQL LEFT JOIN Syntax

		SELECT column_name(s)
		FROM table1
		LEFT JOIN table2
		ON table1.column_name=table2.column_name;
		or:

		SELECT column_name(s)
		FROM table1
		LEFT OUTER JOIN table2
		ON table1.column_name=table2.column_name;


SQL LEFT JOIN Example
	The following SQL statement will return all customers, and any orders they might have:

	Example

	SELECT Customers.CustomerName, Orders.OrderID
	FROM Customers
	LEFT JOIN Orders
	ON Customers.CustomerID=Orders.CustomerID
	ORDER BY Customers.CustomerName;

	PS! In some databases LEFT JOIN is called LEFT OUTER JOIN.
