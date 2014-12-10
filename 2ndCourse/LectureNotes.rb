Named routes are to be used over hard coded links
Named routes will ref the html.erb file that must be created in the named (posrs) folder

Three ways to create a form:
1. HTML
<h4> Creating a new Post </h4>

<h5>Pure HTML form</h5>

<form action='/posts' method='POST'>
Title: <input type='text'>

  <br/>

  <input type='submit'>
</form>
