The SQL SELECT DISTINCT Statement
		In a table, a column may contain many duplicate values; and sometimes you only want to list the different (distinct) values.

		The DISTINCT keyword can be used to return only distinct (different) values.

		SQL SELECT DISTINCT Syntax

		SELECT DISTINCT column_name,column_name
		FROM table_name;


SELECT DISTINCT Example
The following SQL statement selects only the distinct values from the "City" columns from the "Customers" table:

Example

SELECT DISTINCT City FROM Customers;
