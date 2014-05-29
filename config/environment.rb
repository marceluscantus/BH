# Load the rails application
require File.expand_path('../application', __FILE__)
BH::Application.configure do

  # config exists only here

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end
# Initialize the rails application
BH::Application.initialize!
