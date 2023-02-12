class AppointmentsController < ApplicationController
  before_action :authenticate_request

  def index
    appointments = Appointments.find_by_user(@current_user_id)

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
    # TODO check user id
    Appointments.destroy(params[:id])

    head :ok
  end

  private

  def appointment_params
    params.permit(:title, :desc, :start, :end).merge(user_id: @current_user_id)
  end

  def decorator_class
    AppointmentDecorator
  end
end
