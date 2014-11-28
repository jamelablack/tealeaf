1. First thing to do is review the ERD diagram - entity relationship diagram

2. There is a sub for create table in the migration file:

  def up #the change you want to make
    create table
  end



  def down #when you want to rollback
    drop table
  end

3. In Rails Console, in order to see what the expected table name is for your
model, type "Post".tabelize

4. To add_column to existing table by
  - running rails g migration add_column_to_table
  - open migration and add:
      def change
        add_column :table, :column_name, :field_type
#example add_column :posts, :updated_at, :datetime
      end
5. In a 1:M, foreign_key is expected on the has_many table

6. What if we wanted to change the association name from user, to creator.

  class Post < ActiveRecord::Base
    belongs_to :creators, foreign_key: 'user_id', class_name: 'User'
  end

7. After generating migration
- check ERD for columns in table and data types
- run "rails g migration create_comments"
- open migration file and add columns
- run rake db:migrate
- create empty model class
- open rails console and check to see if model is connected to database
- Then open model and add reationships
  - has_many requires plural model
  - foreign_key is added to the has_many table but is written in the model on
    belongs_to side
  - You only need to specify the foereign key and class with the assumptions are not correct:
    It will assume that the foreign_key will be "post_id" and the model is Post.
8. Inside the console:
    - You have to match your association getter/setters with the object to object or id to id:
    for example: creator: User.first or user_id: User.first.id
    - you have the option of choosing the assocation getter/setter defined in your model or the
    column name

9. Understand what the assocations are saying:
class Comment < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	belongs_to :post
end

belongs_to - refers to the current table
This is saying that on the comment table, I am expecting a foreign_key of user_id
and post_id

has_many:
class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
end
On the post and comments tab, I except a forgeign_key of user_id
