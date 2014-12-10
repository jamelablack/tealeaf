1.never hardcode ids ...
    post_path(post))

Partials
1. When creating partials:
1.1 For partials that are application/resource wide, you should place them in a folder under the "views" called
"shared"
1.2 Extract common code
1.3 <%= render 'shared/content_title', title: @post.title %>
  Where title: can take a string or you can call a method like @post.title

1.4 <%= render @post.categories %>
    Expects the partial to be placed in categories folder, _catergory.html.erb file
1.5 <%= render @post.categories %>
    is a replacement of:
        <% @post.each do |post| %>
        <%=  render 'posts/post' post: post %>
        <% end %>
1.6 <% @post.categories.each do |categories| %>
    <span class="badge"><%= category.name %></span>
    <% end %>

     is replaced by
     <span class="badge"><%= category.name %></span>
