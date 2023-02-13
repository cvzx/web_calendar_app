module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_by_auth_token
  end

  def current_user
    @current_user
  end

  private

  def authenticate_user_by_auth_token
    user = AuthenticationService.auth_by_token(request.headers['Auth'])

    @current_user = user
  end
end
