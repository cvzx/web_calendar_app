class AppointmentsController < ApplicationController
  def index
    render json: { appointments: Appointments.all }
  end

  def show

  end
end
