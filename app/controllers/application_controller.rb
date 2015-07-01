class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :day_deals
  before_filter :guest_user_cart

  def after_sign_in_path_for(resource)
    items_from_guest_to_user
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource)
    guest_user_cart
    root_path
  end

  def day_deals
    @deals = [Item.first, Item.last]
    @feature_products = Item.all.limit(16)
  end

  def guest_user_cart
    return if current_user
    session[:guest_user] ||= {total: 0.0, count: 0}
    session[:guest_cart] ||= {} # {item_id: total_products, ...}
  end

  def items_from_guest_to_user
    current_user.add_items_from_guest(session[:guest_cart])
    session[:guest_user] = {total: 0.0, count: 0}
    session[:guest_cart] = {}
  end


end
