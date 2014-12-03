Rails.application.config.middleware.use OmniAuth::Builder do
  provider :gca, ENV["GCA_SSO_APP_ID"], ENV["GCA_SSO_APP_SECRET"]
end
