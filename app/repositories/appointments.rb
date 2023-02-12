# frozen_string_literal: true

class Appointments
  class << self
    def all
      Appointment.all
    end

    def find(id)
      Appointment.find(id)
    end

    def find_by_user(user)
      Appointment.where(user_id: user.id)
    end

    def create(user, params)
      create_params = populate_attributes(params).merge(user_id: user.id)

      Appointment.create!(create_params)
    end

    def update(id, user, params)
      appointment = find(id)

      raise 'Access Denied' if user.id != appointment.user_id

      appointment.update!(populate_attributes(params))
    end

    def destroy(id, user)
      appointment = find(id)

      raise 'Access Denied' if user.id != appointment.user_id

      appointment.destroy!
    end

    private

    def populate_attributes(params)
      params.to_h.symbolize_keys => {
        user_id: user_id,
        title: title,
        desc: description,
        start: start_date,
        end: end_date
      }

      { user_id:, title:, description:, start_date:, end_date: }
    end
  end
end
