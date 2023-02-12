class Authentication
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def authenticate_by_credentials(username, password)
      Users.find_by_username(username)&.authenticate(password)
    end

    def authenticate_by_token(token)
      user_id = decode_token(token).fetch('user_id')

      Users.find_by_id(user_id)
    rescue JWT::DecodeError
      nil
    end

    def generate_auth_token(user)
      JWT.encode({ user_id: user.id }, SECRET_KEY)
    end

    private

    def decode_token(token)
      JWT.decode(token.gsub('Bearer ', ''), SECRET_KEY)[0]
    end
  end
end
