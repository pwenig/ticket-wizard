OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weebly, ENV['APP_ID'], ENV['AP_SECRET'], scope: 'read:site'
end