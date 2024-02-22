class SessionsController < ApplicationController
  def new
  end

  def create
  user = User.find_for_database_authentication(email: params[:session][:email].downcase)
    if user && user.valid_password?(params[:session][:password])
    reset_session
    sign_in(user)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_to boards_path # またはユーザーをリダイレクトしたい任意のパス
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
