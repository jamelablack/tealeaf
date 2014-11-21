ProcesssPosts.rb

require 'rubygems'
require 'sinatra'

set :sessions, true

get '/form' do 
	erb :form
end

post '/myaction' do
	puts params['username']#performs some sort of action on the data collected
end




#Under views, create "form.erb" under views. Form.erb will render bootstrap from layouts.
form.erb

<form action='/myaction' method='post'> #must explicitly specify the method if not using a 'GET'
	<input type='text' name='username'/> #we add a handle, "name='username' to inspect and perform some action on the data submited
	<input type='submit' class='btn' />
</form>


