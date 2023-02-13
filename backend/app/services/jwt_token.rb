class JwtToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(payload)
    token = payload&.gsub('Bearer ', '')

    JWT.decode(token, SECRET_KEY)[0]
  end
end
