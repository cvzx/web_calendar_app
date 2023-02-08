# frozen_string_literal: true

class Appointments
  Appointment = Struct.new(:id, :user_id, :title, :description, :date_range, keyword_init: true)

  class << self
    def all
      # return all appointments
      [1, 2, 3]
    end

    def find(id)
      # find appointment by id
    end

    def create(params)
      # validate params
      # create appointment in repo
      User.new(params)
    end

    def update(params)
      # find appointment by id
      # validate params
      # update appointment in repo
      User.new(params)
    end

    def destroy(id)
      # find appointment by id
      # delete appointment in repo
      id
    end
  end
end
