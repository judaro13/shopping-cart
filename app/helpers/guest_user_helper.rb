module GuestUserHelper
  def user_cart_total
    if user_signed_in?
      current_user.cart.total
    else
      session[:guest_user]['total']
    end
  end

  def user_cart_count
    if user_signed_in?
      current_user.cart.count
    else
      session[:guest_user]['count']
    end
  end
end
