class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create, :log_out ]
  
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      log_in_user(@user)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def log_out
    log_out_user(current_user) if logged_in?
    redirect_to page_path(:home)
  end
  

end
