Depending on the database, schemas can be very simple and terse or very complicated and precisely defined. Rails isn’t that interested in the details of database schema implementations, however, because its “choose your own database backend” approach limits how tightly it can bond to any particular one. As a result, Rails takes the terse and simple approach, supporting only these basic data types:

:string
:text
:integer
:float
:decimal
:datetime
:timestamp
:time
:date
:binary
:boolean

Rails won’t create a database schema much more complicated than the one shown in Figure B.2, Multiple but unconnected tables in a database”, though it will probably add some extra pieces to the schema that you don’t need to worry about. 
There are timestamps, which Rails adds even when you don’t ask for them, and IDs, which you don’t control but which come up in URLs all the time. 
The Rails ID serves another function inside the database: it’s a primary key, a unique identifier for that row in the table. 
Databases can find information very rapidly when given that key.


Limitations of Tables

There is a huge amount of data out there that doesn’t fit neatly into tables. Most of the time, in web applications, you can just put the pieces that do fit into tables, and put the pieces that don’t fit easily (like pictures, or XML files) in the filesystem somewhere.

If you get into situations where little of the information you’re working with fits neatly into tables—lots of hierarchical information, for instance—you may want to go looking for other kinds of tools. You might need a different kind of database, an XML store maybe, and you probably won’t find Rails to be your best option. Rails bindings for XML databases could be very cool—ActiveDocument?—but certainly aren’t a mainstream tool at present.




Connecting Tables

You can build many simple applications on a single-table database, but at some point, working within a single table is just way too constraining. The next step might be add another table to the application, say for some completely separate set of issues. A users table that identifies users and their administrative roles might be the next thing you add to an application, as shown in Figure B.2, “Multiple but unconnected tables in a database”.

With these tables, you can write an application that checks to see if users have the rights to make changes to the other table. You could add lots of other disconnected tables to the database as well (and sometimes you’ll have disconnected tables), but at the same time, this isn’t taking advantage of the real power of relational databases. They’re much more than a place to store information in tables: they’re a place to managed related information effectively and efficiently.

So, how does that work? Remember the primary key? Rails uses it to get to records quickly, but the database can also use it internally. That means that it’s easy for data in one table to refer to a row in another using that same primary key. That yields structures like the one shown in Figure B.3, “Connected tables in a database”.



Establishing connections between tables is simple—one just has to reference the other using its key. 
When you link to a record in another table by storing the key for that record in your own table, that key is called a foreign key. 
By using foreign keys to connect to primary keys, databases can assemble related information very quickly. Whose “2007 Best Handwriting” award was that? Student 1, who we can find out is Giles Boschwick by checking the other table.

You can link tables to tables to tables. You might, for example, have a table that lists who presented each award, which links to the award table the same way that the award table linked to the students table, as shown in Figure B.4, “Connected tables in a database”.



Using Tables to Connect Tables

These kinds of links allow the table doing the pointing to establish one connection per row. That might lead to no connections to some rows in the targeted table, one connection to a row, or even many connections to given rows in the targeted table. You can constrain those options, but there’s one kind of connection that isn’t supported by this simple mechanism. It doesn’t allow for many-to-many relationships.

A classic many-to-many relationship is students and classes. 
Often, each student takes many classes. Each class contains many students. 
The mechanism shown in Figures B.3 and B.4 isn’t very good at this. 
You could create multiple fields for holding multiple links to the same table, but any time you have more than one field pointing at the same table, you’re setting yourself up for some complicated processing. 
It’s hard to know how many pointers you’ll need, and all of your code would have to look in multiple different places to establish connections. 
None of this is fun.

Note

It’s fine, even normal, to have multiple foreign keys in a table, as long as they all reference different tables.

There is, however, a convenient way to represent many-to-many relationships without creating a tangle. 
Instead of putting pointers from one table to another inside of the table, you create a third table that contains pointers to the two other tables. 
If you need to represent multiple relationships between different rows in the two tables to be joined, it’s easy—just add another row specifying the connection in the table representing connections.

