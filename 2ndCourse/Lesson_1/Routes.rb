Routes.rb

http://guides.rubyonrails.org/routing.html

1. CONNECTING URLS TO CODE

  If your application recieves the following request:  GET/patient/17
  It asks your router to match it to the proper controller action:

      get '/patients/id', patients#show


2. Generating Paths and URLs from Code ============
You can also generate paths and URLs. If the route above is modified to be:

get '/patients/:id', to: 'patients#show', as: 'patient'
and your application contains this code in the controller:

@patient = Patient.find(17)
and this in the corresponding view:

<%= link_to 'Patient Record', patient_path(@patient) %>
then the router will generate the path /patients/17.
This reduces the brittleness of your view and makes your code easier to understand.
Note that the id does not need to be specified in the route helper

3. CRUD

Memorize

4. Singular Resources ==============================
Sometimes, you have a resource that clients always look up without referencing an ID.
For example, you would like /profile to always show the profile of the currently logged in user.
In this case, you can use a singular resource to map /profile (rather than /profile/:id)
  to the show action:

get 'profile', to: 'users#show'
Passing a String to get will expect a controller#action format, while passing a
Symbol will map directly to an action:

get 'profile', to: :show

4. Controller Namespaces and Routing ======================
You may wish to organize groups of controllers under a namespace.
Most commonly, you might group a number of administrative controllers under an
Admin:: namespace. You would place these controllers under the app/controllers/admin
directory, and you can group them together in your router:

namespace :admin do
  resources :posts, :comments
end
If you want to route /posts (without the prefix /admin) to Admin::PostsController, you could use:

scope module: 'admin' do
  resources :posts, :comments
end
or, for a single case:

resources :posts, module: 'admin'
If you want to route /admin/posts to PostsController (without the Admin:: module prefix), you could use:

scope '/admin' do
  resources :posts, :comments
end
or, for a single case:

resources :posts, path: '/admin/posts'

5.Nested Resources==============
It's common to have resources that are logically children of other resources.
For example, suppose your application includes these models:

class Magazine < ActiveRecord::Base
  has_many :ads
end

class Ad < ActiveRecord::Base
  belongs_to :magazine
end
Nested routes allow you to capture this relationship in your routing.
In this case, you could include this route declaration:

resources :magazines do
  resources :ads
end

=========Limits to Nesting

You can nest resources within other nested resources if you like. For example:

resources :publishers do
  resources :magazines do
    resources :photos
  end
end
Deeply-nested resources quickly become cumbersome. In this case, for example,
  the application would recognize paths such as:

/publishers/1/magazines/2/photos/3
The corresponding route helper would be publisher_magazine_photo_url, requiring
you to specify objects at all three levels. Indeed, this situation is confusing
enough that a popular article by Jamis Buck proposes a rule of thumb for good Rails design:

Resources should never be nested more than 1 level deep.

====================Shallow Nesting

One way to avoid deep nesting (as recommended above) is to generate the collection actions
scoped under the parent, so as to get a sense of the hierarchy, but to not nest the member actions.
In other words, to only build routes with the minimal amount of information to uniquely identify
the resource, like this:

resources :posts do
  resources :comments, only: [:index, :new, :create]
end
resources :comments, only: [:show, :edit, :update, :destroy]
This idea strikes a balance between descriptive routes and deep nesting.
There exists shorthand syntax to achieve just that, via the :shallow option:

resources :posts do
  resources :comments, shallow: true
end
This will generate the exact same routes as the first example.
You can also specify the :shallow option in the parent resource,
in which case all of the nested resources will be shallow:

resources :posts, shallow: true do
  resources :comments
  resources :quotes
  resources :drafts
end
The shallow method of the DSL creates a scope inside of which every nesting is shallow.
This generates the same routes as the previous example:

shallow do
  resources :posts do
    resources :comments
    resources :quotes
    resources :drafts
  end
end
There exist two options for scope to customize shallow routes. :shallow_path prefixes
member paths with the specified parameter:

scope shallow_path: "sekret" do
  resources :posts do
    resources :comments, shallow: true
  end
end
The :shallow_prefix option adds the specified parameter to the named helpers:

scope shallow_prefix: "sekret" do
  resources :posts do
    resources :comments, shallow: true
  end
end

===============2.8 Routing concerns
Routing Concerns allows you to declare common routes that can be reused inside
other resources and routes. To define a concern:

concern :commentable do
  resources :comments
end

concern :image_attachable do
  resources :images, only: :index
end
These concerns can be used in resources to avoid code duplication and share behavior across routes:

resources :messages, concerns: :commentable

resources :posts, concerns: [:commentable, :image_attachable]
The above is equivalent to:

resources :messages do
  resources :comments
end

resources :posts do
  resources :comments
  resources :images, only: :index
end
Also you can use them in any place that you want inside the routes, for example
in a scope or namespace call:

namespace :posts do
  concerns :commentable
end

===================2.9 Creating Paths and URLs From Objects
In addition to using the routing helpers, Rails can also create paths and URLs from an array of parameters. For example, suppose you have this set of routes:

resources :magazines do
  resources :ads
end
When using magazine_ad_path, you can pass in instances of Magazine and Ad instead of the numeric IDs:

<%= link_to 'Ad details', magazine_ad_path(@magazine, @ad) %>
You can also use url_for with a set of objects, and Rails will automatically determine which route you want:

<%= link_to 'Ad details', url_for([@magazine, @ad]) %>
In this case, Rails will see that @magazine is a Magazine and @ad is an Ad and will therefore use the magazine_ad_path helper. In helpers like link_to, you can specify just the object in place of the full url_for call:

<%= link_to 'Ad details', [@magazine, @ad] %>
If you wanted to link to just a magazine:

<%= link_to 'Magazine details', @magazine %>
For other actions, you just need to insert the action name as the first element of the array:

<%= link_to 'Edit Ad', [:edit, @magazine, @ad] %>
This allows you to treat instances of your models as URLs, and is a key advantage to using the resourceful style.
