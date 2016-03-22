Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['OMNI_AUTH_KEY_1'], ENV['OMNI_AUTH_KEY_2'],
  		    scope: 'public_profile', info_fields: 'id,name,link,email'
end
