# frozen_string_literal: true

class Appointments
  class << self
    def all
      Appointment.all
    end

    def find(id)
      Appointment.find(id)
    end

    def create(params)
      # validate params
      title = params['title']
      description = params['desc']
      datetime_range = DateTime.parse(params['start'])..DateTime.parse(params['end'])

      Appointment.create!(title:, description:, datetime_range:)
    end

    def update(id, params)
      # validate params
      appointment = find(id)

      title = params['title']
      description = params['desc']
      datetime_range = DateTime.parse(params['start'])..DateTime.parse(params['end'])

      appointment.update!(title:, description:, datetime_range:)
    end

    def destroy(id)
      appointment = find(id)
      appointment.destroy!
    end
  end
end
