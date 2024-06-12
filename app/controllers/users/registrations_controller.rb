class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def create
    super do |resource|
      if resource.persisted?
        begin
          WelcomeMailer.send_when_signup(resource.email, resource.name).deliver_now
          flash.now[:notice] = I18n.t('devise.registrations.signed_up')
        rescue StandardError => e
          Rails.logger.error("Failed to send welcome email: #{e.message}")
          flash.now[:alert] = I18n.t('devise.registrations.signed_up_but_unconfirmed')
        end
      else
        flash.now[:alert] = I18n.t('devise.registrations.failed', errors: resource.errors.full_messages.join(', '))
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
end
