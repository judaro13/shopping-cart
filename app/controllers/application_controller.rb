class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :day_deals
  before_filter :guest_user_cart
  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    items_from_guest_to_user 
    session[:previous_url] || root_path
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
