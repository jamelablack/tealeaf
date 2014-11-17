
The SQL ORDER BY Keyword
		The ORDER BY keyword is used to sort the result-set by one or more columns.

		The ORDER BY keyword sorts the records in ascending order by default. To sort the records in a descending order, you can use the DESC keyword.

		SQL ORDER BY Syntax

		SELECT column_name,column_name
		FROM table_name
		ORDER BY column_name,column_name ASC|DESC;

	ORDER BY Example
The following SQL statement selects all customers from the "Customers" table, sorted by the "Country" column:

Example

		SELECT * FROM Customers
		ORDER BY Country;


		ORDER BY DESC Example
		The following SQL statement selects all customers from the "Customers" table, sorted DESCENDING by the "Country" column:

		Example

		SELECT * FROM Customers
		ORDER BY Country DESC;


		ORDER BY Several Columns Example
		The following SQL statement selects all customers from the "Customers" table, sorted by the "Country" and the "CustomerName" column:

		Example

		SELECT * FROM Customers
		ORDER BY Country,CustomerName;


