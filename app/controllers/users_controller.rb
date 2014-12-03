class UsersController < ApplicationController
  before_action :current_user_acts_as_admin, only: [:index, :destroy]

  def index
    @users = User.all
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url, :notice => "User has been deleted" }
      format.json { head :ok }
    end
  end
  
end
