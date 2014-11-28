Agenda:
- review, q&a
- migrations
- assignments: 1:M and M:M
  -habtm vs hmt
- resources / routes


Migrations
You cannot push database becasue its a application (like MSWord).
But you can push SQLite to github b/c there it is a file.
Migrations reflect the incremental changes in the schema
  - Do not modify migration files once created, the order of exectution matter
  and will cause your migration to fail if there are conflicts.
  Using rollback isnt good after pushing your code because when working on teams,
  the database only keeps track of that number and won't reflect your changes on
  their local machine b/c they already ran migration 4, for example.

1:M
Things to remember:
1. add_column to migrations:
  add_column :posts, :user_id, :integer

2.Virtual Attribute:
class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name "User"
end

3. When you have a forgeign_key (post_id, user_id)on your table, you can call
  comment.post = Post.first OR comment.post_id = Post.first.id

ONLY specify foreign_keys in the model layer

habtm vs hmt
Database layer:
- join table

Model layer:
1. has_and_belongs_to_many
  - no join model
  - implicit join table at db layer
    - table1_name_table2 ex: groups_users (must be alphabetical)

  Problems:
  - can't put additional attributes (columns) on association


2. has_many :through
    - has a join model
    - can put additional attributes (columns) on assocation

  Problems:
  - has a join model

With hmt you have list the associations in proper order in the models.
  - has_many and then has_many.... through

Resources:
@instance variables created in your controller allow us to retrieve data that we can render in our views

Include resources and create a nested url:

  resources: posts except: [:destroy] do
    resources [:comments], omly: :[create]
  end
Nesting urls takes routes that logcially belong in that url/path of your application.



Check routes at localhost:3000/rails/info/routes
Memorize your path/routes.



Named routes is what we use when we want to write a url... we never what to write
in a string:
  in erb:
  <%= link_to 'go back to all posts', '/posts' %>

  instead... use the named routes

  <%= link_to 'go back to all posts', posts_path %>

Why?
Example - you have to re-route some of your routes to another sub-domain
Example - you have to change your http to https://
- lesson- never use strings in urls  - its a code smell and it will increase your
  technical dabt
