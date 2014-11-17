The SQL LIKE Operator
The LIKE operator is used to search for a specified pattern in a column.

SQL LIKE Syntax

SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern;



SQL LIKE Operator Examples
The following SQL statement selects all customers with a City starting with the letter "s":

Example

SELECT * FROM Customers
WHERE City LIKE 's%';

Try it yourself »
Tip: The "%" sign is used to define wildcards (missing letters) both before and after the pattern. You will learn more about wildcards in the next chapter.

The following SQL statement selects all customers with a City ending with the letter "s":

Example

SELECT * FROM Customers
WHERE City LIKE '%s';


Try it yourself »
The following SQL statement selects all customers with a Country containing the pattern "land":

Example

SELECT * FROM Customers
WHERE Country LIKE '%land%';

Try it yourself »
Using the NOT keyword allows you to select records that does NOT match the pattern.

The following SQL statement selects all customers with a Country NOT containing the pattern "land":

Example

SELECT * FROM Customers
WHERE Country NOT LIKE '%land%';