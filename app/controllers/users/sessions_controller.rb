class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    render json: { message: '로그인 성공', resource: resource }, status: :ok
  end
  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end
  def log_out_success
    render json: { message: "로그아웃 성공" }, status: :ok
  end
  def log_out_failure
    render json: { message: "로그아웃 실패" }, status: :unauthorized
  end
end