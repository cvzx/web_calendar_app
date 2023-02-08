# frozen_string_literal: true

class Appointments
  class << self
    def all
      # return all appointments
      Appointment.all
    end

    def find(id)
      # find appointment by id
      Appointment.find(id)
    end

    def create(params)
      # validate params
      # create appointment in repo
      Appointment.create!(params)
    end

    def update(params)
      # find appointment by id
      # validate params
      # update appointment in repo
      appointment = find(params.slice(:id))
      appointment.update!(params)
    end

    def destroy(id)
      # find appointment by id
      # delete appointment in repo
      appointment = find(params.slice(:id))
      appointment.destroy!(params)
    end
  end
end
