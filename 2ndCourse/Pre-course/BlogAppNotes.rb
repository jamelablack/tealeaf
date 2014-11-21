BlogAppNotes.rb

1. Create Rails App:
COMMAND: rails new BlogAppNotes

2.Create controler
A controller's purpose is to recieve specific requests for the application.
Routing decides which controller recieves which requests. There is ofet more than route to each controller and different routes can be served by different actions.
Each action's purpose is to collect information and provide it to a view.

A view's purpose is to display this information in a human readable format. An important distinction to make is
that the controller, not the view, is where information is collected. The view should be a displayof that information
using embedded ruby - which is processed in the request cyce before going to the user.

To create a new controller, you will need to run the controller generator, tell it you want a controller called "welcome" and an action called "index":

COMMAND: rails generate controller welcome index

Most important of these are of course the controller, located at app/controllers/welcome_controller.rb and the view, located at app/views/welcome/index.html.erb.

Open the app/views/welcome/index.html.erb file in your text editor. Delete all of the existing code in the file, and replace it with the following single line of code:

			<h1>Hello, Rails!</h1>
3. Setting the Home application Page
Open config/routes:
COMMAND: Rails.application.routes.draw do
  get 'welcome/index'

Find the line beginning with root and uncomment it. It should look something like the following:

root 'welcome#index'

4. Create a Resource:
A resource is the term used for a collection of similar objects, such as articles, people or animals.
You can create, read, update and destroy items for a resource and these operations are referred to as CRUD operations.
 ACTION: Add 'resource :articles' to your config/routes.rb file


5. Then run rake routes

6. Generate your articles controller:
	rails g controller articles

7. Create articles/new:
Go to Articles controller and create new method:

	def new

	end

8. Create app/views/articles/new.html.erb
		ADD: Html
		ADD: Form erb syntax to allow submission of article data
9. Refresh and complete form and press 'submit'

10. You will get an error that '/create' is undefined. You must create the 'create'
method in your controller, as you did with 'new'
