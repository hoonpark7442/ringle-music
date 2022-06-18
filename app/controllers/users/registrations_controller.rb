class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end
  def register_success
    render json: { message: '회원가입 성공', resource: resource }, status: :ok
  end
  def register_failed
    render json: { message: "회원가입 실패", errors: resource.errors }, status: :bad_request
  end
end