http://guides.rubyonrails.org/layouts_and_rendering.html

2 Creating Responses
From the controller's point of view, there are three ways to create an HTTP response:

Call render to create a full response to send back to the browser
Call redirect_to to send an HTTP redirect status code to the browser
Call head to create a response consisting solely of HTTP headers to send back to the browser


2.2 Using render
In most cases, the ActionController::Base#render method does the heavy lifting of
rendering your application's content for use by a browser.
There are a variety of ways to customize the behavior of render. You can render
the default view for a Rails template, or a specific template, or a file, or inline
code, or nothing at all. You can render text, JSON, or XML. You can specify the content type or HTTP status of the rendered response as well.

If you want to see the exact results of a call to render without needing to inspect it in a browser, you can call render_to_string. This method takes exactly the same options as render, but it returns a string instead of sending a response back to the browser.

2.2.1 Rendering Nothing

Perhaps the simplest thing you can do with render is to render nothing at all:

      render nothing: true

2.2.2 Rendering an Action's View

If you want to render the view that corresponds to a different template within
the same controller, you can use render with the name of the view:

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to(@book)
  else
    render "edit"
  end
end
If the call to update fails, calling the update action in this controller will render the edit.html.erb template belonging to the same controller.

If you prefer, you can use a symbol instead of a string to specify the action to render:

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to(@book)
  else
    render :edit
  end
end


2.2.3 Rendering an Action's Template from Another Controller

What if you want to render a template from an entirely different controller from
the one that contains the action code?
You can also do that with render, which accepts the full path (relative to app/views)
  of the template to render. For example, if you're running code in an AdminProductsController
  that lives in app/controllers/admin, you can render the results of an action to a template in
  app/views/products this way:

  render "products/show"

Rails knows that this view belongs to a different controller because of the embedded slash
character in the string. If you want to be explicit, you can use the :template option (which
was required on Rails 2.2 and earlier):

      render template: "products/show"


2.2.4 Rendering an Arbitrary File

The render method can also use a view that's entirely outside of your application
(perhaps you're sharing views between two Rails applications):

render "/u/apps/warehouse_app/current/app/views/products/show"
Rails determines that this is a file render because of the leading slash character.
 To be explicit, you can use the :file option (which was required on Rails 2.2 and earlier):

render file: "/u/apps/warehouse_app/current/app/views/products/show"
The :file option takes an absolute file-system path. Of course, you need to have rights to the view that you're using to render the content.

By default, the file is rendered without using the current layout.
If you want Rails to put the file into the current layout, you need
 to add the layout: true option.

=============================

2.3 Using redirect_to
Another way to handle returning responses to an HTTP request is with redirect_to.
As you've seen, render tells Rails which view (or other asset) to use in constructing a response.
 The redirect_to method does something completely different: it tells the browser to send a new
 request for a different URL. For example, you could redirect from wherever you are in your code to
  the index of photos in your application with this call:

redirect_to photos_url
You can use redirect_to with any arguments that you could use with link_to or url_for.
 There's also a special redirect that sends the user back to the page they just came from:

redirect_to :back
2.3.1 Getting a Different Redirect Status Code

Rails uses HTTP status code 302, a temporary redirect, when you call redirect_to.
If you'd like to use a different status code, perhaps 301, a permanent redirect,
you can use the :status option:

redirect_to photos_path, status: 301
Just like the :status option for render, :status for redirect_to accepts both numeric
 and symbolic header designations.

2.3.2 The Difference Between render and redirect_to

Sometimes inexperienced developers think of redirect_to as a sort of goto command,
moving execution from one place to another in your Rails code. This is not correct.
Your code stops running and waits for a new request for the browser. It just happens
that you've told the browser what request it should make next, by sending back an HTTP
302 status code.

Consider these actions to see the difference:

def index
  @books = Book.all
end

def show
  @book = Book.find_by(id: params[:id])
  if @book.nil?
    render action: "index"
  end
end
With the code in this form, there will likely be a problem if the @book variable is nil.
Remember, a render :action doesn't run any code in the target action, so nothing will
set up the @books variable that the index view will probably require. One way to fix this is
to redirect instead of rendering:

def index
  @books = Book.all
end

def show
  @book = Book.find_by(id: params[:id])
  if @book.nil?
    redirect_to action: :index
  end
end
With this code, the browser will make a fresh request for the index page, the code
in the index method will run, and all will be well.

The only downside to this code is that it requires a round trip to the browser:
 the browser requested the show action with /books/1 and the controller finds that
 there are no books, so the controller sends out a 302 redirect response to the browser
 telling it to go to /books/, the browser complies and sends a new request back to the
 controller asking now for the index action, the controller then gets all the books in the
 database and renders the index template, sending it back down to the browser which then shows
 it on your screen.

While in a small application, this added latency might not be a problem, it is something
to think about if response time is a concern. We can demonstrate one way to handle this
with a contrived example:

def index
  @books = Book.all
end

def show
  @book = Book.find_by(id: params[:id])
  if @book.nil?
    @books = Book.all
    flash.now[:alert] = "Your book was not found"
    render "index"
  end
end
This would detect that there are no books with the specified ID, populate the @books
instance variable with all the books in the model, and then directly render the index.html.erb
 template, returning it to the browser with a flash alert message to tell the user what happened.

 =======================

 3.4 Using Partials
Partial templates - usually just called "partials" - are another device for breaking the rendering process into more manageable chunks. With a partial, you can move the code for rendering a particular piece of a response to its own file.

3.4.1 Naming Partials

To render a partial as part of a view, you use the render method within the view:

<%= render "menu" %>
This will render a file named _menu.html.erb at that point within the view being rendered.
Note the leading underscore character: partials are named with a leading underscore to distinguish
them from regular views, even though they are referred to without the underscore. This holds true
even when you're pulling in a partial from another folder:

<%= render "shared/menu" %>
That code will pull in the partial from app/views/shared/_menu.html.erb.

3.4.2 Using Partials to Simplify Views

One way to use partials is to treat them as the equivalent of subroutines: as a way
to move details out of a view so that you can grasp what's going on more easily.
For example, you might have a view that looked like this:

<%= render "shared/ad_banner" %>

<h1>Products</h1>

<p>Here are a few of our fine products:</p>
...

<%= render "shared/footer" %>
Here, the _ad_banner.html.erb and _footer.html.erb partials could contain content
that is shared among many pages in your application. You don't need to see the details
of these sections when you're concentrating on a particular page.

For content that is shared among all pages in your application, you can use partials
directly from layouts.

3.4.3 Partial Layouts

A partial can use its own layout file, just as a view can use a layout. For example,
you might call a partial like this:

<%= render partial: "link_area", layout: "graybar" %>
This would look for a partial named _link_area.html.erb and render it using the layout _graybar.html.erb.
 Note that layouts for partials follow the same leading-underscore naming as regular partials, and are
 placed in the same folder with the partial that they belong to (not in the master layouts folder).

Also note that explicitly specifying :partial is required when passing additional options such as
 :layout.
