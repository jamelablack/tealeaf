The SQL WHERE Clause 
The WHERE clause is used to extract only those records that fulfill a specified criterion.

	SQL WHERE Syntax

	SELECT column_name,column_name
	FROM table_name
	WHERE column_name operator value;

	WHERE Clause Example
		The following SQL statement selects all the customers from the country "Mexico", in the "Customers" table:

		Example

		SELECT * FROM Customers
		WHERE Country='Mexico';

		Text Fields vs. Numeric Fields
SQL requires single quotes around text values (most database systems will also allow double quotes).

		However, numeric fields should not be enclosed in quotes:

		Example

		SELECT * FROM Customers
		WHERE CustomerID=1;

Operators in The WHERE Clause
The following operators can be used in the WHERE clause:

Operator	Description
		=	Equal
		<>	Not equal. Note: In some versions of SQL this operator may be written as !=
		>	Greater than
		<	Less than
		>=	Greater than or equal
		<=	Less than or equal
		BETWEEN	Between an inclusive range
		LIKE	Search for a pattern
		IN	To specify multiple possible values for a column


The SQL AND & OR Operators
		The AND operator displays a record if both the first condition AND the second condition are true.

		The OR operator displays a record if either the first condition OR the second condition is true.


AND Operator Example
		The following SQL statement selects all customers from the country "Germany" AND the city "Berlin", in the "Customers" table:

		Example

		SELECT * FROM Customers
		WHERE Country='Germany'
		AND City='Berlin';

OR Operator Example
		The following SQL statement selects all customers from the city "Berlin" OR "München", in the "Customers" table: 

		Example

		SELECT * FROM Customers
		WHERE City='Berlin'
		OR City='München';

Combining AND & OR
		You can also combine AND and OR (use parenthesis to form complex expressions).

		The following SQL statement selects all customers from the country "Germany" AND the city must be equal to "Berlin" OR "München", in the "Customers" table:

		Example

		SELECT * FROM Customers
		WHERE Country='Germany'
		AND (City='Berlin' OR City='München');

