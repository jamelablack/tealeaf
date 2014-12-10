Quiz: Lesson 1

Quiz from lesson one materials. You can do this yourself, or create a new gist or blog entry, answer the quiz, and post the link to the forums and others can take a look.

Why do they call it a relational database?
  *Because the tables within database are connected by relationships

What is SQL?
  *Standard Query Language

There are two predominant views into a relational database. What are they, and how are they different?
  1. Schema view
  2. Data view

In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.
  *primary_key

What is a foreign key, and how is it used?
  *Foreign_key goes on the "has_many" table and is the id that connects the primary_key from the "belongs_to" to create
    that association

At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.
  *ActiveRecord uses ruby to execute SQL scripts

If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?
  *crazy_monkies

If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?
  *One project has many issues => foreign_key: issue_id



Given this code

class Zoo < ActiveRecord::Base
  has_many :animals
end
What do you expect the other model to be and what does database schema look like?
    *Animals, belongs_to :zoo, foreign_key: :zoo_id
What are the methods that are now available to a zoo to call related to animals?
  *zoo.animal.first
How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?
  *Animal.create(name:"jumpter")
What is mass assignment? What's the non-mass assignment way of setting values?
  *Mass way => Resource.create(name: "Jam", age: "30")
  *Non mass way => resource.name = "Jam"

What does this code do? Animal.first
  *Returns the first Animal with an id of 1

If I have a table called "animals" with columns called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe".
Which methods makes sure it saves to the database?
Animal.create(name:"Joe") or joe = Animal.new(name:"Joe"), then joe.save

How does a M:M association work at the database level?
  Requires a join table or join model at the model layer to connect the ids


What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?
    Has_many_through
    Cons
    requires a join model
    Pros
    can addtional attributes later on

    or Has_many_
    Cons
    requires a join table at the database layer
    will not allow for additional attributes
    Pros
    Does not require a seperate join model

Suppose we have a User model and a Group model, and we have a M:M association all set up.
How do we associate the two?
  habtm:
  user => has and belongs_to :groups
  group => has_and_belongs to :users
  create join table groups_users
