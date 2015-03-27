class SessionsController < GcaSsoClient::SessionsController
  skip_before_action :authenticate_user!
  skip_before_action :validate_session

  protected
  
  def permitted_roles
    :all
  end
  
end