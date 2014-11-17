The SQL CREATE TABLE Statement
The CREATE TABLE statement is used to create a table in a database.

Tables are organized into rows and columns; and each table must have a name.

		SQL CREATE TABLE Syntax

		CREATE TABLE table_name
		(
		column_name1 data_type(size),
		column_name2 data_type(size),
		column_name3 data_type(size),
		....
		);
The column_name parameters specify the names of the columns of the table.

The data_type parameter specifies what type of data the column can hold (e.g. varchar, integer, decimal, date, etc.).

The size parameter specifies the maximum length of the column of the table.

Tip: For an overview of the data types available in MS Access, MySQL, and SQL Server, go to our complete Data Types Reference.


SQL CREATE TABLE Example
Now we want to create a table called "Persons" that contains five columns: PersonID, LastName, FirstName, Address, and City.

We use the following CREATE TABLE statement:

Example

		CREATE TABLE Persons
		(
		PersonID int,
		LastName varchar(255),
		FirstName varchar(255),
		Address varchar(255),
		City varchar(255)
		);


The PersonID column is of type int and will hold an integer.

The LastName, FirstName, Address, and City columns are of type varchar and will hold characters, and the maximum length 
for these fields is 255 characters.