class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    include Pundit
    rescue_from ActiveRecord::RecordNotUnique, with: :duplicate_error_response
  
    protected
    # rescue method for duplicate email error
    def duplicate_error_response(exception)
        render json: { error: exception.message }, status: :bad_request
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :first_name])
    end
end
