# frozen_string_literal: true

class AppointmentsService
  def initialize(user, repo = Appointment)
    @user = user
    @repo = repo
  end

  def list_all
    repo.where(user_id: user.id)
  end

  def find_by_id(id)
    list_all.find(id)
  end

  def create(params)
    create_params = params.merge(user_id: user.id)

    repo.create!(create_params)
  end

  def update(id, params)
    appointment = find_by_id(id)

    appointment.update!(params)
  end

  def destroy(id)
    appointment = find_by_id(id)

    appointment.destroy!
  end

  private

  attr_reader :user, :repo
end
