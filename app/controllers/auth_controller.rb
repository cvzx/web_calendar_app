class AuthController < ApplicationController
  def login
    user = Authentication.authenticate_by_credentials(username, password)

    if user.present?
      token = Authentication.generate_auth_token(user)

      render json: { token: }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
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
