class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'application'

  def show
    @exception       = env['action_dispatch.exception']
    @status_code     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    view = [500, 404].include?(@status_code) ? @status_code.to_s : :show

    respond_to do |format|
      format.html { render view, status: @status_code, layout: !request.xhr? }
      format.xml  { render nothing: :true, status: @status_code }
      format.json { render nothing: :true, status: @status_code }
    end
  end
  
end
