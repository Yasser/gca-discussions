module ApplicationHelper
  def current_user
    return nil if session[:user].nil?
    @current_user ||= User.find_by(uid: session[:user])
  end

  def current_user_can_upload?
    current_user.acts_as(:documentadmin, :board, :office, :scheduling, :quality)
  end

  def user_signed_in?
    return true if current_user
  end
  
  def message_user_link(user)
    host = OmniAuth::Strategies::Gca.default_options['client_options']['site']
    link_to user.name, "#{host}/users/#{user.uid}/messages/new"
  end
  
  def draft_count
    @draft_count || (@drafts || []).size
  end
end
