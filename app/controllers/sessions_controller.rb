class SessionsController < GcaSsoClient::SessionsController
  skip_before_action :authenticate_user!
  skip_before_action :validate_session

  def index
    redirect_to :signin
  end
  
  protected
  
  def permitted_roles
    :all
  end
  
end