# frozen_string_literal: true

class AppointmentsService
  class ValidationError < StandardError; end

  def initialize(user, repo = Appointment, validator = Appointment)
    @user = user
    @repo = repo
    @validator = validator
  end

  def list_all
    repo.where(user_id: user.id)
  end

  def find_by_id(id)
    list_all.find(id)
  end

  def create(params)
    create_params = params.merge(user_id: user.id)

    validate_params!(create_params)

    repo.create(create_params)
  end

  def update(id, params)
    appointment = find_by_id(id)
    update_params = appointment.attributes.merge(params)

    validate_params!(update_params)

    appointment.update(params)
  end

  def destroy(id)
    appointment = find_by_id(id)

    appointment.destroy!
  end

  private

  attr_reader :user, :repo, :validator

  def validate_params!(params)
    validation = validator.new(params)

    return if validation.valid?

    raise ValidationError, validation.errors.full_messages.join(',')
  end
end
