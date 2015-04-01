class ApplicationController < ActionController::Base
  include GcaSsoClient::Authentication
  
  protect_from_forgery with: :exception
  force_ssl unless Rails.env.development?
  
  before_action :authenticate_user!
  before_action :validate_session
end