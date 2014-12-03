class SessionsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :validate_session
  before_action :sync_access_groups, only: [:create]

  def new
    redirect_to '/auth/gca'
  end
  
  def index
  end

  def create
    auth = request.env["omniauth.auth"]
    roles = auth['info']['group']
    
    redirect_to root_url, alert: "You do not have sufficient priveleges to use this application." unless permitted(roles)

    user = User.find_by(uid: auth['uid'])
    
    if user
      attributes = {access_group_ids: AccessGroup.where(key: roles).select(:id).map(&:id), admin: roles.include?("admin")}
      [:first_name, :last_name, :title].each do |n|
        attributes.merge!({n => auth['info'][n.to_s]}) if auth['info'][n.to_s] != user.send(n)
      end
      user.assign_attributes(attributes)
      user.set_timestamps_from_request(request)
      user.save
    else
      params_from_sso = {uid: auth['uid'], first_name: auth['info']['first_name'], last_name: auth['info']['last_name'], title: auth['info']['title'], email: auth['info']['email'], access_group_ids: AccessGroup.where(key: roles).select(:id).map(&:id), admin: roles.include?("admin"), current_sign_in_at: Time.now, current_sign_in_ip: request.remote_ip}
      parameters = ActionController::Parameters.new(params_from_sso)
      user = User.create(parameters.permit(:uid, :first_name, :last_name, :title, :email, :admin, :current_sign_in_at, :current_sign_in_ip, :access_group_ids => []))
    end
    session[:user] = user.uid
    session[:trusted] = auth['extra']['session_trusted']
    session[:expires_at] = Time.parse(auth['extra']['expires_at']) if session[:trusted]
    session[:last_activity] = Time.now

    redirect_to root_url, notice: "Successfully authenticated: #{current_user.name}"
  end
  
  def idle
    expire_session
  end

  def destroy
    if user_signed_in?
      prior_flash = flash[:notice]
      current_user.rotate_timestamps
      reset_session
      flash[:notice] = prior_flash || "You have successfully signed out."
    end
    redirect_to root_url
  end

  def failure
    redirect_to (request.env['omniauth.origin'] || root_url), alert: "Authentication error: #{params[:message].humanize}"
  end
  
  protected
  
  def permitted(roles)
    (roles & [permitted_roles].flatten).size > 0 || roles.include?("admin") || permitted_roles == :all
  end
  
  def permitted_roles
    :all
  end
  
  def sync_access_groups
    access_groups = Rails.cache.fetch(:access_groups, expires_in: 1.day) do
      request = GcaSsoApi.new('/api/users/groups.json').get
      if request.response.status == 200
        access_groups = JSON.parse request.response.body
      end
      access_groups
    end
    access_groups["groups"].each do |group|
      AccessGroup.create(key: group["key"], title: group["title"], group_key: group["group"], group_title: access_groups["categories"].select{|c| c["key"] == group["group"]}.first["title"]) if !AccessGroup.where(key: group["key"]).exists?
    end
  end
  
end