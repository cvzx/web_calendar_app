class AppointmentsController < ApplicationController
  def index
    appointments = Appointments.all

    render json: { appointments: decorate_collection(appointments) }
  end

  def create
    Appointments.create(appointment_params)

    head :ok
  end

  def update
    Appointments.update(params[:id], appointment_params)

    head :ok
  end

  def destroy
    Appointments.destroy(params[:id])

    head :ok
  end

  private

  def appointment_params
    params.permit(:title, :desc, :start, :end)
  end

  def decorator_class
    AppointmentDecorator
  end
end
