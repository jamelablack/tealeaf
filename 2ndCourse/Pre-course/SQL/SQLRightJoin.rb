SQL RIGHT JOIN Keyword
The RIGHT JOIN keyword returns all rows from the right table (table2), with the matching rows in the left table (table1). The result is NULL in the left side when there is no match.

SQL RIGHT JOIN Syntax

SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name=table2.column_name;
or:

SELECT column_name(s)
FROM table1
RIGHT OUTER JOIN table2
ON table1.column_name=table2.column_name;
PS! In some databases RIGHT JOIN is called RIGHT OUTER JOIN.


SQL Lcase()
SQL Mid()
SQL Len()
SQL Round()
SQL Now()
SQL Format()

SQL Quick Ref
SQL Hosting

SQL Quiz
SQL Quiz

SQL RIGHT JOIN Keyword

« PreviousNext Chapter »
SQL RIGHT JOIN Keyword
The RIGHT JOIN keyword returns all rows from the right table (table2), with the matching rows in the left table (table1). The result is NULL in the left side when there is no match.

SQL RIGHT JOIN Syntax

SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name=table2.column_name;
or:

SELECT column_name(s)
FROM table1
RIGHT OUTER JOIN table2
ON table1.column_name=table2.column_name;
PS! In some databases RIGHT JOIN is called RIGHT OUTER JOIN.

SQL RIGHT JOIN

Demo Database
In this tutorial we will use the well-known Northwind sample database.

Below is a selection from the "Orders" table:

		OrderID	CustomerID	EmployeeID	OrderDate	ShipperID
		10308	2	7	1996-09-18	3
		10309	37	3	1996-09-19	1
		10310	77	8	1996-09-20	2
		And a selection from the "Employees" table:

		EmployeeID	LastName	FirstName	BirthDate	Photo	Notes
		1	Davolio	Nancy	12/8/1968	EmpID1.pic	Education includes a BA in psychology.....
		2	Fuller	Andrew	2/19/1952	EmpID2.pic	Andrew received his BTS commercial and....
		3	Leverling	Janet	8/30/1963	EmpID3.pic	Janet has a BS degree in chemistry....

		SQL RIGHT JOIN Example
		The following SQL statement will return all employees, and any orders they have placed:

		Example

		SELECT Orders.OrderID, Employees.FirstName
		FROM Orders
		RIGHT JOIN Employees
		ON Orders.EmployeeID=Employees.EmployeeID
		ORDER BY Orders.OrderID;