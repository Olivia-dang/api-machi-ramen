class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    include Pundit
    rescue_from ActiveRecord::RecordNotUnique, with: :duplicate_error_response
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActionController::ParameterMissing, :with => :param_missing

    protected
    # when a param is missing
    def param_missing(exception)
        render json: { error: exception.message }, status: :bad_request
    end

    # rescue method for duplicate email error
    def duplicate_error_response(exception)
        render json: { error: exception.message }, status: :bad_request
    end

    # rescue method when couldn't find the record requested
    def record_not_found(exception)
        render json: { error: exception.message }, status: :not_found
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :first_name])
    end
end
