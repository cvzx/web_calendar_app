class ApplicationController < ActionController::API
  def decorate_collection(collection)
    collection.map {|item| decorate(item) }
  end

  def decorate(item)
    decorator_class.new(item)
  end

  def decorator_class
    raise NotImplemented
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
