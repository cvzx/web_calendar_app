class ApplicationController < ActionController::API
  def authenticate_request
    user = AuthenticationService.auth_by_token(request.headers['Auth'])

    @current_user = user
  rescue AuthenticationService::AuthError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def decorate_collection(collection)
    collection.map { |item| decorate(item) }
  end

  def decorate(item)
    decorator_class.new(item)
  end

  def decorator_class
    raise NotImplemented
  end
end
