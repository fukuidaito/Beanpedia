# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:success, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end

  def line
    basic_action
  end

  private
  
  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      sign_in(:user, @profile)
    end
    #ログイン後のflash messageとリダイレクト先を設定
    flash[:notice] = "ログインしました"
    redirect_to expendable_items_path
  end

  def fake_email(uid, provider)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
