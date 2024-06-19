class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from StandardError, with: :render500
  rescue_from ActiveRecord::RecordNotFound, with: :render404
  include SessionsHelper
  include Pagy::Backend
  add_flash_types :success, :info, :warning, :danger
  require 'line/bot'

  def render404(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render template: 'errors/render404', layout: 'error', status: :not_found
  end

  def render500(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render template: 'errors/render500', layout: 'error', status: :internal_server_error
  end

  private

  def after_sign_in_path_for(_resource)
    boards_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:name, :avatar, :email, :password, :password_confirmation, :current_password]
    )
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:name, :avatar, :email, :password, :password_confirmation]
    )
    devise_parameter_sanitizer.permit(
      :reset_password,
      keys: [:email]
    )
  end
end
