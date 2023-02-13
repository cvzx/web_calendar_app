class AuthController < ApplicationController
  def login
    user = AuthenticationService.auth_by_credentials(username, password)
    auth_token = AuthenticationService.generate_auth_token(user)

    render json: { token: auth_token}, status: :ok
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
end
