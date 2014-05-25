class Notifier < ActionMailer::Base  
default_url_options[:host] = "localhost:3000"  
default :from => "marcelcl@gmail.com" 
	def password_reset_instructions(user)  
		@url = edit_password_reset_url(user.perishable_token)  
		mail(:to => user.email, :subject => "Resetear password!")
	end  
end  