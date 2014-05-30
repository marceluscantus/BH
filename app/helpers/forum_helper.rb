module ForumHelper
	def display_like_a_tree(posts)
	    content = ''.html_safe
	    for post in posts
	      url = link_to("#{h post.subject}", {:action => 'show', :id => post.id})
	      button = button_to('Borrar', {:action => 'destroy', :id => post.id})
	      margin_left = post.depth*20
	      content << %(<div style="margin-left:#{margin_left}px">
			#{url} by #{h post.name} &middot; #{post.created_at.strftime("%H:%M:%S %Y-%M-%d") }#{button} 
			</div>).html_safe
		end
	content
	end
end