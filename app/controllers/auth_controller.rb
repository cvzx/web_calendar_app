class AuthController < ApplicationController
  def login
    user = auth_service.auth_by_credentials(username, password)
    auth_token = auth_service.generate_auth_token(user)

    render json: { token: auth_token}, status: :ok
  rescue AuthenticationService::AuthError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def auth_params
    params.permit(:username, :password)
  end

  def username
    auth_params[:username]
  end

  def password
    auth_params[:password]
  end

  def auth_service
    AuthenticationService
  end
end
