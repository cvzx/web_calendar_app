class AuthenticationService
  class AuthError < StandardError; end

  class << self
    def auth_by_token(token)
      payload = JwtToken.decode(token)

      users_service.find_by_id(payload['user_id'])
    rescue ActiveRecord::RecordNotFound
      raise AuthError, 'Not Authorized'
    end

    def auth_by_credentials(username, password)
      users_service.find_by_credentials(username, password)
    rescue ActiveRecord::RecordNotFound
      raise AuthError, 'Invalid email or password'
    end

    def generate_auth_token(user)
      JwtToken.encode({ user_id: user.id })
    end

    private

    def users_service
      @users_service ||= UsersService.new
    end
  end
end
