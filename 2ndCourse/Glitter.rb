1. Create mockup
2. Create user and status migrations, add associations
3. Create route for '/:username'
4. Create controller for user, including show, and same for statuses_controller, show
5. Add new user link, and new status link to nav
6. Extract errors into a _partial
7. Add Flash messages into a _partial
8. Create registration, add has secure passord, bcyprt, and update model backed form
Authentication
10. Add link for login to routes using sessions, create sessions controller, and new.html.erb sessions
11. Know the difference b/w non-model new/create actions:
class SessionsController < ApplicationController
def new

end

def create
	user = User.find_by username: params[:username]
	if user && user.authenticate(params[:password])

		flash[:notice] = "You're logged in!"
		redirect_to user_path

	else
		flash.now[:error] = "There is something wrong with your username or password."
		render :new

	end
end


	AND model backed new/create actions:
		def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:notice] = "You're now registered!"
			redirect_to user_path(@user.username)
		else
			render :new
		end
	end
	12. Now when to use flash.now with render and flash with redirect_to (submits on the next 
		request). You would never have a redirect_to in an html.erb file

	13. Add before_action to statuses_controller new and create actions to prevent http requests to those associations

14. How to use Boostrap
- You can just grab the application.css and application.js file and add it your application. 
- Follow documentation. but basically you are going to install the bootstrap-sass and bootstrap-sprockets gem
- Then change your application.css file to application.scss and add @imports, also add requires to your application.js file
 15. Now we can add bootstrap to our alerts:
 <div>
<% if flash.keys.any? %>
 	<% flash.keys.each do |key| %>
 	<div class="alert alert-<%= key == :notice ? 'success' : 'danger' %>" role="alert"> STOP look below
 		<%= flash[key] %>
 		<div/>
 	<% end %>	
<% end %>
</div>

The point of this is that you can use ruby to change to class name to success or danger (html)
16. The above code:
 	<div class="alert alert-<%= key == :notice ? 'success' : 'danger' %>" role="alert">
 	is expecting the key :notice as a symbol but the binding.pry reveals that is coming over as a string. So we
 	have to change :notice to 'notice' 

17. Followers/Unfollowers Model
Lets call them followers and leaders
We want to create a table that captures those relationships.
class User < ActiveRecord::Base
	has_secure_password
	has_many :statuses

	#must specify associations within the join model b/c you're working on both side of the model(User)
	has_many :follower_relationships, class_name: "Relationship", foreign_key: "leader_id"
	has_many :leader_relationships, class_name: "Relationship", foreign_key: "follower_id"
	#users that are following me
	has_many :follower_users, through: :follower_relationships, source: :follower
	#users that I follow
	has_many :following_users, through: :leader_relationships, source: :leader

	validates :username, presence: true
	validates :email, presence: true

end
_____

class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
	belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'

end

18. Create follow action in the users controller
	def follow
		user = User.find(params[:id])
		if user
			current_user.following_users << user
			flash[:notice] = "You are now following #{user.username}"
			redirect_to user_path(user.username)
		else
			wrong_path
		end
	end

19. Adding Unfollow:
Routes:
  resources :users, only: [:new, :create] do 
  	member do 
  		get 'follow'
  		get 'unfollow'
  	end
  end

View:
<h3><%= link_to "@#{@user.username}", user_path(@user.username) %></h3>
<% if logged_in? %>
	<% if !current_user.following_users.include?(@user) %>
		<%= link_to "+ follow #{@user.username}", follow_user_path(@user) %>
	<% else %>
	<%= link_to "- unfollow #{@user.username}", unfollow_user_path(@user) %>
	<% end %>
<% end 

_______

	def follow
		user = User.find(params[:id])
		if user
			current_user.following_users << user
			flash[:notice] = "You are now following #{user.username}."
			redirect_to user_path(user.username)
		else
			wrong_path
		end
	end

	def unfollow
		user = User.find(params[:id])
		rel = Relationship.where(follower: current_user, leader: user).first
		if user && rel
			rel.destroy
			flash[:notice] = "You are no longer following #{user.username}."
			redirect_to user_path(user.username)
		else
			wrong_path
		end
	end

	20. Timeline
	1. Create Route
		get "/timeline", to: 'users#timeline'
	2. Create controller action in users
		def timeline
		@statuses = []
		current_user.following_users.each.do |user|
			@statuses << user.statuses.all
		end
		@statuses.flatten!
	end

	3. Create the view under users
	<%= render 'shared/header', header: "Timeline" %>

	<ul>
	<% @statuses.each do |status| %>
		<li><%= status.body %> by <%= status.creator.username%> at <%= status.created_at %></li>
	<% end %>
</ul>

	4. Changing the get verbs to post for follow and unfollow.
	It's not semantically correct to submit data to the database using a get, 
	we should change that to post, and can do so using method: post in the views. The code that comes
		with rails to handle his can be found in the jquery.ujs file within firebug:

	Routes:
  resources :users, only: [:new, :create] do 
  	member do 
  		post 'follow'
  		post 'unfollow'
  	end
  end 

  Views:
  <h3><%= link_to "@#{@user.username}", user_path(@user.username) %></h3>
<% if logged_in? %>
	<% if !current_user.following_users.include?(@user) %>
		<%= link_to "+ follow #{@user.username}", follow_user_path(@user), method: 'post' %>
	<% else %>
	<%= link_to "- unfollow #{@user.username}", unfollow_user_path(@user), method: 'post' %>
	<% end %>
<% end %>
_______
Mentions

Create migration for join table migrations:
class Mention < ActiveRecord::Base
	belongs_to :user 
	belongs_to :status
end

1. Create route
	get "/mentions", to: 'users#mentions'

2. Create controller action, add 
class UsersController < ApplicationController
	before_action :require_user, only: [:follow, :unfollow, :mentions]
	def mentions


	end
3. Create veiws: (basically same as )

<%= render 'shared/header', header: "Mentions" %>

<ul>
<% current_user.mentions.each do |mention| %>
	<li><%= mention.status.body %> by <%= mention.status.creator.username%> at <%= mention.status.created_at %></li>
<% end %>
</ul>

4. Now we have to create the mentions, this is done is the models.
We need to create method that will run in the after_save callback:

class Status < ActiveRecord::Base
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

	validates :creator, presence: true
	validates :body, presence: true, length: {minimum: 5}
	after_save :extract_mentions


	def extract_mentions
		mentions = self.body.scan(/@(\w*)/)
		if mentions.size > 0
			mentions.each do |mention|
				m = mention.first
				user = User.find_by username: m
				if user
					Mention.create(user_id: user.id, status_id: self.id)
				end
			end
		end
	end
end

___________________________
Adding Mention viewed
Lets add a notfication that will tell you if you have unveiwed mentions
1. Create migration to add veiwed_at column to mentions
2. Add syntax to top_nav
	<%= link_to "Mentions (#{current_user.num_unread_mentions})", mentions_path %> |
3. Create num_unread_mentiods method in the user model bc it is concerning data:
	def num_unread_mentions
		mentions.where(viewed_at: nil).count
	end

	def unread_mentions
		mentions.where(viewed_at: nil)
	end

	def mark_unread_mentions!
		unread_mentions.each do |mention|
			mention.mark_viewed!
		end
	end
	4. Create method within mention.rb that will update eveytime the mention is viewed:
		def mark_viewed!
		self.update(viewed_at: Time.now)
	end
	5. Call the above method in the mentions action within the users_controller:
		def mentions
		current_user.mark_unread_mentions!
	end

	_________

	Adding Hashtags and linking mentions:
	1. Create your hashtags route:
	  resources :hashtags, only:[:show]

	2. Create Template under hashtags/show.html.erb

<%= render 'shared/header', header "Statuses for hashtag ##{params[:id]}" %>

<ul>
	<% @statuses.each do |status| %>
	<li><%= render 'statuses/status', status: status %></li>
	<% end %>
</ul>

Create action:
class HashtagsController < ApplicationController


	def show
		@status = Status.where("body LIKE ?", "%##{params[:id]}%")
	end

end

3. Create ApplicationHelper
module ApplicationHelper
module ApplicationHelper

	def auto_links(str)
		str = link_hashtag(str)
		str = link_mentions(str)
		str.html_safe
	end


	def link_hashtag(str)
		str.gsub(/#(\w+)/, "<a href='/hashtags/\\1'>#\\1</a>")
	end

	def link_mentions(str)
		str.gsub(/@(\w+)/, "<a href='/\\1'>@\\1</a>")
	end
end

end
4. Edit statuses/status partial to include new link_hashtag method that can be seen in all places 
using the partial

<%= auto_links(status.body) %> created by <%= link_to status.creator.username, user_path(status.creator.username) %>

___________________________
Retweets
1. Add link to status partial
<%= auto_links(status.body) %> created by <%= link_to status.creator.username, user_path(status.creator.username) %>

<% if logged_in? && status.creator != current_user %>
	[<%= link_to 'retweet', retweet_status_path(status), method: 'post' %>]

<% end %>
2. Creat Route
  resources :statuses, only: [:new, :create, :index] do
    member do
      post 'retweet'
    end
  end
3. We need a way to track the association of reweet to parent status:
- Run migration to add retweet_id column to status table
- add assoction to retweet_id in status model:
	class Status < ActiveRecord::Base
		belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
		belongs_to :parent_status, class_name: 'Status', foreign_key: 'reweet_id'
	end
4. Now complete the rewteet action in the status controller:
	def retweet
		status = Status.find(params[:id])
		new_status = Status.new(body: status.body, creator: current_user, parent_status: status)

		if new_status.save
			flash[:notice] = "Retweeted!"
		else
			flash[:error] = "Couldn't retweet!"
		end
		redirect_to :back
	end
5. Update _status partial:
<%= auto_links(status.body) %> <%= link_to '*', status_path(status.parent_status) if status.retweet_id %>

<% if status.retweet_id %> 
	retweeted by 
<% else %>
	created by 
<% end %>
<%= link_to status.creator.username, user_path(status.creator.username) %>

<% if logged_in? && status.creator != current_user %>
	[<%= link_to 'retweet', retweet_status_path(status), method: 'post' %>]

<% end %>




