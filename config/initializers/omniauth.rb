Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1538519413114703', 'b62ea4f602ec1ef0111b36e412fbf95d',
  		    scope: 'public_profile', info_fields: 'id,name,link,email'
end