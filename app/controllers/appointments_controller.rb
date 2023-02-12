class AppointmentsController < ApplicationController
  before_action :authenticate_request

  def index
    appointments = Appointments.find_by_user(@current_user)

    render json: { appointments: decorate_collection(appointments) }
  end

  def create
    Appointments.create(@current_user, appointment_params)

    head :ok
  end

  def update
    Appointments.update(params[:id], @current_user, appointment_params)

    head :ok
  end

  def destroy
    Appointments.destroy(params[:id], @current_user)

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
