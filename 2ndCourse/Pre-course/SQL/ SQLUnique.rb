SQL UNIQUE Constraint
	The UNIQUE constraint uniquely identifies each record in a database table.

	The UNIQUE and PRIMARY KEY constraints both provide a guarantee for uniqueness for a column or set of columns.

	A PRIMARY KEY constraint automatically has a UNIQUE constraint defined on it.

	Note that you can have many UNIQUE constraints per table, but only one PRIMARY KEY constraint per table.

	SQL UNIQUE Constraint on CREATE TABLE
	The following SQL creates a UNIQUE constraint on the "P_Id" column when the "Persons" table is created:

			SQL Server / Oracle / MS Access:

			CREATE TABLE Persons
			(
			P_Id int NOT NULL UNIQUE,
			LastName varchar(255) NOT NULL,
			FirstName varchar(255),
			Address varchar(255),
			City varchar(255)
			)
			MySQL:

			CREATE TABLE Persons
			(
			P_Id int NOT NULL,
			LastName varchar(255) NOT NULL,
			FirstName varchar(255),
			Address varchar(255),
			City varchar(255),
			UNIQUE (P_Id)
			)
To allow naming of a UNIQUE constraint, and for defining a UNIQUE constraint on multiple columns, use the following SQL syntax:

MySQL / SQL Server / Oracle / MS Access:

CREATE TABLE Persons
(
P_Id int NOT NULL,
LastName varchar(255) NOT NULL,
FirstName varchar(255),
Address varchar(255),
City varchar(255),
CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName)
)
SQL UNIQUE Constraint on ALTER TABLE
To create a UNIQUE constraint on the "P_Id" column when the table is already created, use the following SQL:

MySQL / SQL Server / Oracle / MS Access:

ALTER TABLE Persons
ADD UNIQUE (P_Id)
To allow naming of a UNIQUE constraint, and for defining a UNIQUE constraint on multiple columns, use the following SQL syntax:

MySQL / SQL Server / Oracle / MS Access:

ALTER TABLE Persons
ADD CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName)

To DROP a UNIQUE Constraint
To drop a UNIQUE constraint, use the following SQL:

MySQL:

ALTER TABLE Persons
DROP INDEX uc_PersonID
SQL Server / Oracle / MS Access:

ALTER TABLE Persons
DROP CONSTRAINT uc_PersonID