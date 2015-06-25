class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :day_deals

  def day_deals
    @deals = [Item.first, Item.last]
    @feature_products = Item.all.limit(16)
  end

end
