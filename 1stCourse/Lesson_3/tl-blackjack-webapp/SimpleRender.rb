require 'rubygems'
require 'sinatra'

set :sessions, true

#using render

get '/simplerender' do
	"Hi, this is my first render!"
end

#using a template

get '/simpletemplate' do 
	erb :simpletemplate
end

get '/simple_nested_template' do
	erb :'/nests/nested_things/simple_nested_template'


end