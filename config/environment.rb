# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Gratifiled::Application.initialize!

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "gratifiled.herokuapp.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: "gratifiled@gmail.com",
  password: "planetargon"
}