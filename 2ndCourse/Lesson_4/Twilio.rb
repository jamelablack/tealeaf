Two factor authentication upon login:

Pseudo code:
1. We need a phone number and pin columns
2. Change login logic:
a. If phone number not present, normal login
b. If phone number present
  - generate pin to save to db, not show user
  - send pin to Twilio to sms user's phone
  - show a form to enter the pin (generate new route myapp.com/pin)
    - must ensure its secure, can only be seen after user has logged in

_______

1. Add column phone and pin column to users:
- rails g migration add_phone_and_pin_to_users
- class AddPhoneAndPinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :pin, :string
  end
end

2. Add phone input field to your users/new.html.erb
<div class='control-group'>
  <%= f.label :phone, "Phone Number <small>(numbers only)</small>".html_safe %>
  <%= f.text_field :phone, maxlength: 9 %>
  <%= link_to '#', id: 'two_factor_phone' do %>
    <i class='icon-question-sign'></i>
  <% end %>
</div>

3. Also, we need to add :phone to strong_parameters
def user_params
  params.require(:user).permit(:username, :password, :time_zone, :phone)
end

4. So after the phone number is entered by the user, we want to prevent them from
logging in directly and prompt them for their pin and connect with Twilio.
The login occurs in the sessions controller:
def create
  user = User.where(username: params[:username]).first
  if user && user.authenticate(params[:password])
    ****if user.two_factor_auth? #must create this method


    else
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in."
      redirect_to root_path
    end
  else
    flash[:error] = "There is something with your username & password."
    redirect_to login_path
  end
end


5. Create two_factor_auth? method in your user model:

  def two_factor_auth?
    !self.phone.blank?
  end

6. We have to now breakdown what else we need
def create
  user = User.where(username: params[:username]).first
  if user && user.authenticate(params[:password])
    if user.two_factor_auth?
      #generate a pin
      user.generate_pin!
      #send pin to twilio, sms user's phone
      #show pin form for user input after sms


    else
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in."
      redirect_to root_path
    end
  else
    flash[:error] = "There is something with your username & password."
    redirect_to login_path
  end

end

7. Create generate_pin! method:
  def generate_pin!
    self.update_column(:pin, rand(10 **6)) #generate a random six digit number
  end

8. Skip the send pin to twilio part for now


9. Show pin form for the user input:
routes.rb:
get '/pin', to: 'sessions#pin'
post '/pin', to: 'sessions#pin'


10. Adding the above routes, gives us the pin_path route which we can redirect to:
def create
  user = User.where(username: params[:username]).first
  if user && user.authenticate(params[:password])
    if user.two_factor_auth?
      #generate a pin
      user.generate_pin!
      #send pin to twilio, sms user's phone

      #show pin form for user input after sms
      redirect_to pin_path

    else
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in."
      redirect_to root_path
    end
  else
    flash[:error] = "There is something with your username & password."
    redirect_to login_path
  end

end

11. Now create a pin.html.erb file under views:




12. Now when attempting to go to the get '/pin' upon being redirected to the pin_path,
notice that the get method work without even creating the action. ** When there is a link,
the default is to render. This will not work when the method post is called bc you are inputing
parameters:
sessions_controller.rb

def pin
  if request.post?
    user = User.find_by(pin: params[:pin])
    if user
      #remove pin
      user.remove_pin!
      #normal login success route
      login_user!(user)
    else
      flash[:error] = "Sorry, something is wrong with the pin you've entered."
      redirect_to pin_path
    end
  end
end

private

def login_user!(user)
  session[:user_id] = user.id
  flash[:notice] = "Welcome, you've logged in."
  redirect_to root_path
end

13. Now we must set prevent users from going to the '/pin' url by entering it
in their browser:
We can do so by setting a session hash to true/false after login attempt/sucessful login
in the sessions_controller:
sessions_controller.rb

#login attempt
  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
#successful login
def pin
  if request.post?
    user = User.find_by(pin: params[:pin])
    if user
      session[:two_factor] = nil
      #remove pin
14. Now we can lock down the url using our access_denied method we previously created:
We can put this in the session#pin bc it impacts both the get and post
sessions_controller.rb

def pin
  access_denied if session[:two_factor].nil?
  if request.post?
    user = User.find_by(pin: params[:pin])
    if user
      session[:two_factor] = nil
      #remove pin
      user.remove_pin!
      #normal login success route
      login_user!(user)
    else
      flash[:error] = "Sorry, something is wrong with the pin you've entered."
      redirect_to pin_path
    end
15. remove.pin! method
user.rb
def remove_pin!
  self.update_column(:pin, nil)
end

16. Now its time to intergrate Twilio
- install the Twilio-Ruby gem

17. Create a method to send to text to user using Twilio api
sessions_controller.rb
def create
  user = User.where(username: params[:username]).first
  if user && user.authenticate(params[:password])
    if user.two_factor_auth?
      session[:two_factor] = true
      #generate a pin
      user.generate_pin!
      #send pin to twilio, sms user's phone
      user.send_pin_to_twilio
      #show pin form for user input after sms
      redirect_to pin_path
18. Create send_pin_to_twilio method in user.rb (using Twilio two factor authentication)
def send_pin_to_twilio
  account_sid ='AC47bdb7f569ae31aa59309f81981aaf37'
  auth_token = 'f3d9c378bba9272d3ed9fec659e353b0'

  # set up a client to talk to the Twilio REST API
  client = Twilio::REST::Client.new account_sid, auth_token
  msg = "Hello, Please enter this pin to continue login: #{self.pin}."
  account = client.account
  message = account.sms.messages.create({
    :from => '+13392985371',
    :to => '202-809-8486',
    :body => msg,
    })

  end
