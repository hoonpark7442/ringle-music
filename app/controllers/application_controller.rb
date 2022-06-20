class ApplicationController < ActionController::API
	before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from PlaylistError::UnauthorizedError do |error|
    error_not_authorized(error.message)
  end

  rescue_from ActiveRecord::RecordNotFound, with: :error_not_found

	def authenticate_user!
    if current_user
      return
    end

      render json: { error: "로그인 해주세요" }, status: :unauthorized 
  end

	private

	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end

  def error_not_authorized(message)
    render json: { error: message, status: 401 }, status: :unauthorized
  end

  def error_not_found
    render json: { error: "not found", status: 404 }, status: :not_found
  end
end
