module Decorators
  extend ActiveSupport::Concern

  private

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
