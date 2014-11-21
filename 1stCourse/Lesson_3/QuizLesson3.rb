# QuizLesson3.rb

# Quiz: Lesson 3

# Please review this quiz, which covers lesson 3 materials.

# What is HTML? What is CSS? What is Javascript?
HTML is the presentation markup but doesn't dictate the look & feel.
CSS presents the look and feel of those markup elemnents. It hooks on to elements in the DOM using CSS Selectors
allowing us to traverse.
Js - each browser will implement in a diff way. JQuery takes of the browser implementation layer and is compatible with 
all browsers

Together all these are the front-end technologlies. Server side Js include Node, Meteor

# What are the major parts of an HTTP request?
1. Verb (post/get)
2. URL
3. Parameter

# What are the major parts of an HTTP response?
1. Status Code
2. Payload/Message

# How do you submit an HTTP POST request, with a "username" attribute set to "bob"? What if we wanted a GET request instead?

# Why is it important for us, as web developers, to understand that HTTP is a "stateless" protocol?
You have to reconstitute the state with each request, we do not have persistant connection to the user. We don't know if you're still that person.
That's why we have banking sessions and social media sessions
# If the internet is just HTTP requests/responses, why do we only use browsers to interface with web applications? Are there any other options?
HTTP requests
Curl
# What is MVC, and why is it important?
We never want to put view code in our models

# The below questions are about Sinatra:
Through renders/redirects of templates

# At a high level, how are requests processed?

# In the controller/action, what's the difference between rendering and redirecting?
Redirects generate a new request

# In the ERB view template, how do you show dynamic content?

# Given what you know about ERB templates, when do you suppose the ERB template is turned into HTML?
ERB Templates re generated at every request.
# What's the role of instance variables in Sinatra?

# Solutions are in the first lecture video of lesson 4.

