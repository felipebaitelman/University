class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :current_password, :password,
                                                              :password_confirmation, :academic_type,
                                                              :sex, :age, :school, :year, :rut, :name])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :academic_type,
                                                       :sex, :age, :school, :year, :rut, :name])
  end
end