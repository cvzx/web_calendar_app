class Users
  class << self
    def find_by_id(id)
      User.find_by(id:)
    end

    def find_by_username(username)
      User.find_by(username:)
    end
  end
end
