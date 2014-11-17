SQL PRIMARY KEY Constraint
The PRIMARY KEY constraint uniquely identifies each record in a database table.

Primary keys must contain unique values.

A primary key column cannot contain NULL values.

Most tables should have a primary key, and each table can have only ONE primary key.

SQL PRIMARY KEY Constraint on CREATE TABLE
The following SQL creates a PRIMARY KEY on the "P_Id" column when the "Persons" table is created:

MySQL:

CREATE TABLE Persons
		(
		P_Id int NOT NULL,
		LastName varchar(255) NOT NULL,
		FirstName varchar(255),
		Address varchar(255),
		City varchar(255),
		PRIMARY KEY (P_Id)
		)
		SQL Server / Oracle / MS Access:

		CREATE TABLE Persons
		(
		P_Id int NOT NULL PRIMARY KEY,
		LastName varchar(255) NOT NULL,
		FirstName varchar(255),
		Address varchar(255),
		City varchar(255)
		)
		To allow naming of a PRIMARY KEY constraint, and for defining a PRIMARY KEY constraint on multiple columns, use the following SQL syntax:

MySQL / SQL Server / Oracle / MS Access:

CREATE TABLE Persons
		(
		P_Id int NOT NULL,
		LastName varchar(255) NOT NULL,
		FirstName varchar(255),
		Address varchar(255),
		City varchar(255),
		CONSTRAINT pk_PersonID PRIMARY KEY (P_Id,LastName)
		)
Note: In the example above there is only ONE PRIMARY KEY (pk_PersonID). However, the value of the pk_PersonID is made up of two columns (P_Id and LastName).
SQL PRIMARY KEY Constraint on ALTER TABLE
To create a PRIMARY KEY constraint on the "P_Id" column when the table is already created, use the following SQL:

MySQL / SQL Server / Oracle / MS Access:

		ALTER TABLE Persons
		ADD PRIMARY KEY (P_Id)
		To allow naming of a PRIMARY KEY constraint, and for defining a PRIMARY KEY constraint on multiple columns, use the following SQL syntax:

MySQL / SQL Server / Oracle / MS Access:

ALTER TABLE Persons
		ADD CONSTRAINT pk_PersonID PRIMARY KEY (P_Id,LastName)
		Note: If you use the ALTER TABLE statement to add a primary key, the primary key column(s) must already have been declared to not contain NULL values (when the table was first created).

		To DROP a PRIMARY KEY Constraint
		To drop a PRIMARY KEY constraint, use the following SQL:

		MySQL:

ALTER TABLE Persons
DROP PRIMARY KEY
SQL Server / Oracle / MS Access:

ALTER TABLE Persons
DROP CONSTRAINT pk_PersonID