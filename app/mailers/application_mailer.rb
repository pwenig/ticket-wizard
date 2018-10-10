class ApplicationMailer < ActionMailer::Base
  default from: 'tickets@ticket-ninja.com'
  layout 'mailer'
end

