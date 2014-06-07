require 'test_helper'

class ForumTest < ActionDispatch::IntegrationTest
	def test_forum
    	jill = new_session_as(:jill)
    	george = new_session_as(:george)
    	post = jill.post_to_forum :post => {
     		:name => 'Bookworm',
      		:subject => 'Downtime',
      		:body => 'Emporium is down again!'
  	  		}
  	  	george.view_forum
    	jill.view_forum

    	george.view_post post
    	george.reply_to_post(post, :post => {
        	:name => 'George',
        	:subject => 'Rats!',
        	:body => 'Rats!!!!!!!!'
			} 
		)
	end
	
	private
	
	module ForumTestDSL
		attr_writer :name
		def post_to_forum(parameters)
              get "/forum/post"
              assert_response :success
              assert_template "forum/post"
              post "/forum/create", parameters
              assert_response :redirect
              follow_redirect!
              assert_response :success
              assert_template "forum/index"
              return ForumPost.find_by_subject(parameters[:post][:subject])
		end
		def view_forum
     		get "/forum"
      		assert_response :success
      		assert_template "forum/index"
      		assert_tag :tag => 'h1', :content => 'Forum'
      		assert_tag :tag => 'a', :content => 'Nuevo debate'
		end
		def view_post(post)
              get "/forum/show/#{post.id}"
              assert_response :success
              assert_template "forum/show"
              assert_tag 'h1', :content => "&#x27;#{post.subject}&#x27;"
		end
		def reply_to_post(post, parameters)
      		get "/forum/reply/#{post.id}"
      		assert_response :success
      		assert_tag 'h1', :content => "Reply to &#x27;#{post.subject}&#x27;"
      		post "/forum/create/#{post.id}", parameters
     		assert_response :redirect
      		follow_redirect!
      		assert_response :success
      		assert_template 'forum/index'
      		assert_tag :a, :content => post.subject
		end
	end
	def new_session_as(name)
		open_session do |session|
		session.extend(ForumTestDSL)
    	session.name = name
    	yield session if block_given?
	end 
	end
end
