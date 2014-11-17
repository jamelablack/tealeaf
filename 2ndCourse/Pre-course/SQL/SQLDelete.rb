The SQL DELETE Statement
The DELETE statement is used to delete rows in a table.

SQL DELETE Syntax

DELETE FROM table_name
WHERE some_column=some_value;

Note	Notice the WHERE clause in the SQL DELETE statement!
The WHERE clause specifies which record or records that should be deleted. 
You omit the WHERE clause, all records will be deleted!

SQL DELETE Example
Assume we wish to delete the customer "Alfreds Futterkiste" from the "Customers" table.

We use the following SQL statement:

Example

DELETE FROM Customers
WHERE CustomerName='Alfreds Futterkiste' AND ContactName='Maria Anders';

Delete All Data
It is possible to delete all rows in a table without deleting the table. This means that the table structure, attributes, and indexes will be intact:

DELETE FROM table_name;

or

DELETE * FROM table_name;
Note: Be very careful when deleting records. You cannot undo this statement!
