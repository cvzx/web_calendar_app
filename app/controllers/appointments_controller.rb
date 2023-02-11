class AppointmentsController < ApplicationController
  before_action :authenticate_request

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

  def authenticate_request
    user = Authentication.authenticate_by_token(request.headers['Auth'])

    if user.present?
      @current_user = user
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
