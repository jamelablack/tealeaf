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
