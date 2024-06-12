class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def create
    super do |resource|
      WelcomeMailer.send_when_signup(resource.email, resource.name).deliver
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
