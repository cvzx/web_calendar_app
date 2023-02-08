# frozen_string_literal: true

class Users
  User = Struct.new(:id, :email, :hashed_password, keyword_init: true)

  class << self
    def find(id)
      nil
    end
  end
end
