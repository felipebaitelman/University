# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


#For confirmation mailing http://stackoverflow.com/questions/8186584/how-do-i-set-up-email-confirmation-with-devise
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
#  :user_name => 'g2pe',
#  :password => 'g2pe2016',
#  :domain => 'http://especial2.ing.puc.cl/',
#  :address => 'smtp.sendgrid.net',
#  :port => '587',
#  :authentication => :plain,
#  :enable_starttls_auto => true,
#  :ssl => false
#}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => 'g2pe',
  :password => 'g2pe2016',
  :domain => 'http://especial2.ing.puc.cl/',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true,

}

