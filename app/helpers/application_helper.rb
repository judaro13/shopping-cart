module ApplicationHelper
  def devise_mapping
    Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end

  def total_in_cart
    if user_signed_in?
      current_user.cart.total_price
    else
      session[:cart][:total_price] ||= 0
    end
  end

end
