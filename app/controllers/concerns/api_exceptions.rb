module ApiExceptions
  extend ActiveSupport::Concern

  included do
    rescue_from AuthenticationService::AuthError do |e|
      render json: { error: e.message }, status: :unauthorized
    end

    rescue_from AppointmentsService::ValidationError do |e|
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
