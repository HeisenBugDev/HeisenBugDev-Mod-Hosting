SimpleTokenAuthentication.configure do |config|
  config.header_names = {
    user: { authentication_token: 'X-Auth-Token', email: 'X-User-Email' }
  }

  # User must provide email and auth token on every request
  config.sign_in_token = false
end
