Let's say you have a User Model
  1. Database:
    id will be the primary key and the table will be name the lowercase, plural
    of the User model

  2. Active Record
  class User

  end

  3. Rails Console:
    - Create in-memory User objects
    user = User.new(username: "Jam", email:"jamela.black@gmail.com")
    - Two ways to save to the database
    1. user.save
    2. user = User.create(username: "Jam", email: "jamela.black@gmail.com")
    **User.create instantly saves to the database, will you must run user.save after running User.new
    3. Retrieve in columns
    user = User.find_by(username: "Jam")
    user.email
    All columns in the table are available for getters and setters. as seen above

1:M Association
Let's say you have a Users table and a Comments table:
    1. Foriegn_key must be added to comments table. The foreign_key will be the primary_key table + primary
    key...so in this case it would be "user_id"

    2. Create join table to add foriegn_key to comments table:
    Terminal: rails g migration add_user_id_to_posts

    3. Add user_id to Active Record
      - User
      class User
        has_many :comments, foriegn_key: :user_id
      end
      - Comments
      class Comment
        belongs_to :user, foreign_key: :user_id
      end

      4.Rails Console
        user = User.create(username: "Chris")

        Create association from relations:
          comment = comments.create(body: "hi")
          user.comments << comment
          comment.user = user; comment.save

        OR

        Manually create the association
          comment = Comment.create(user:"Jam", body: "hi")
          comment = Comment.crete(user_id: 9, body: "hi")

      Then, traverse associations:
        comment.user.username => returns string
        user.comments => returns an array like object
        user.comments.where(body: "hi") => user_id: 9
            user.comments.each do |comment|
              puts comment.body
            end
Another example:
I have two models: (Albums and Product)

1) Inside Models

Inside album.rb:

class Album < ActiveRecord::Base
  attr_accessible :name
  has_many :products
end
Inside product.rb:

class Product < ActiveRecord::Base
  attr_accessible :img, :name, :price, :quantity
  belongs_to :album
end

You can do like this:

  a = Album.create( name: "My Album" )

  p = Product.create( name: "Shampoo X" )
  # OR
  p = Product.create( name: "Shampoo X", album_id: a.id )
  # OR
  p.album = a
  # OR
  p.album_id = a.id
  # OR
  a.products << a
  # finish with a save of the object:
  p.save
  You may have to set the attribute accessible to album_id on the Product model (not sure about that).


  Add the association when you create the Product:

  a = Album.create( :name => "My Album" )
  p = Product.create( :name => "Shampoo X", :album => a )
