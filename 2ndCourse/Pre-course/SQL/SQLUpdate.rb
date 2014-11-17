The SQL UPDATE Statement
	The UPDATE statement is used to update existing records in a table.

	SQL UPDATE Syntax

	UPDATE table_name
	SET column1=value1,column2=value2,...
	WHERE some_column=some_value;

	Note	Notice the WHERE clause in the SQL UPDATE statement!
	The WHERE clause specifies which record or records that should be updated. 
	If you omit the WHERE clause, all records will be updated!



SQL UPDATE Example
	Assume we wish to update the customer "Alfreds Futterkiste" with a new contact person and city.

	We use the following SQL statement:

	Example

	UPDATE Customers
	SET ContactName='Alfred Schmidt', City='Hamburg'
	WHERE CustomerName='Alfreds Futterkiste';
