class UsersService
  def initialize(repo = User)
    @repo = repo
  end

  def find_by_id(id)
    repo.find(id)
  end

  def find_by_credentials(username, password)
    repo.find_by(username:)&.authenticate(password) or raise ActiveRecord::RecordNotFound
  end

  private

  attr_reader :repo
end
