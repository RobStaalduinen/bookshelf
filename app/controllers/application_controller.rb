class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_user
  helper_method :logged_in?

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render :file => 'public/404.html', :status => 404
  end

  def authenticate_user!
    unless logged_in?
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= 
      session[:session_token].present? ? 
        User.find_by(session_token: session[:session_token]) :
        nil
  end

  def log_in_user(user)
    new_session_token = SecureRandom.hex
    user.update(session_token: new_session_token)
    session[:session_token] = new_session_token
    
    @current_user = user
  end

  def log_out_user(user)
    user.update(session_token: nil)
    session[:session_token] = nil
    current_user = nil
  end

  def logged_in? 
    current_user.present?
  end

end
