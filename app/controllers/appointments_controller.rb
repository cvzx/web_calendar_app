class AppointmentsController < ApplicationController
  before_action :authenticate_request

  def index
    appointments = appointment_service.list_all

    render json: { appointments: decorate_collection(appointments) }
  end

  def create
    appointment_service.create(appointment_params)

    head :ok
  end

  def update
    appointment_service.update(params[:id], appointment_params)

    head :ok
  end

  def destroy
    appointment_service.destroy(params[:id])

    head :ok
  end

  private

  def appointment_service
    @appointment_service ||= AppointmentsService.new(@current_user)
  end

  def appointment_params
    params.permit(:title, :description, :start_date, :end_date)
  end

  def decorator_class
    AppointmentDecorator
  end
end
