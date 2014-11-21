Render_Templates_Redirect.rb

#main.rb 


require 'rubygems'
require 'sinatra'

set :sessions, true

#Using Render 
get '/inline' do
	"Hi, directly from the action"
end

#Using Templates 
get '/template' do
	erb :mytemplate #references mytemplate.erb that must be created under the views
end

#Using an Nested Template
get '/nested_template' do
	erb :"/users/profile" #references an erb template called nested_array with the users/profile folder under the views"
end

#Using Redirect
get 'nothere' do
	redirect 'inline'
end

