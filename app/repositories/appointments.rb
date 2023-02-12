# frozen_string_literal: true

class Appointments
  class << self
    def all
      Appointment.all
    end

    def find(id)
      Appointment.find(id)
    end

    def find_by_user(user_id)
      Appointment.where(user_id:)
    end

    def create(params)
      # validate params
      params = params.to_h.symbolize_keys
      params => {user_id: user_id, title: title, desc: description, start: start_date, end: end_date}

      Appointment.create!(title:, description:, start_date:, end_date:, user_id:)
    end

    def update(id, params)
      # validate params
      appointment = find(id)

      params = params.to_h.symbolize_keys
      params => {user_id: user_id, title: title, desc: description, start: start_date, end: end_date}

      appointment.update!(title:, description:, start_date:, end_date:, user_id:)
    end

    def destroy(id)
      appointment = find(id)
      appointment.destroy!
    end
  end
end
