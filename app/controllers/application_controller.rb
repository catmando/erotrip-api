class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def acting_user
    current_user
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :kind,
        :name,
        :birth_year,
        :name_second_person,
        :birth_year_second_person,
        :city,
        :email,
        :password,
        :password_confirmation,
        :pin,
        :pin_confirmation,
        :terms_acceptation
      ])
    end

end
