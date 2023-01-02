class Api::V1::Overrides::RegistrationsController < DeviseTokenAuth::RegistrationsController
  prepend_before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name default_currency))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name default_currency))
  end
end