The SQL INSERT INTO Statement
The INSERT INTO statement is used to insert new records in a table.

SQL INSERT INTO Syntax

	It is possible to write the INSERT INTO statement in two forms.

	The first form does not specify the column names where the data will be inserted, only their values:

	INSERT INTO table_name
	VALUES (value1,value2,value3,...);
	The second form specifies both the column names and the values to be inserted:

	INSERT INTO table_name (column1,column2,column3,...)
	VALUES (value1,value2,value3,...);

		INSERT INTO Example
		Assume we wish to insert a new row in the "Customers" table.

		We can use the following SQL statement:

Example

INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES ('Cardinal','Tom B. Erichsen','Skagen 21','Stavanger','4006','Norway');

Insert Data Only in Specified Columns
It is also possible to only insert data in specific columns.

The following SQL statement will insert a new row, but only insert data in the "CustomerName", "City", and "Country" columns (and the CustomerID field will of course also be updated automatically):

Example

INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');

	