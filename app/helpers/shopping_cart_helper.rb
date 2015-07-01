module ShoppingCartHelper
  TITLE = [['Mr','Mr'],
            ['Mrs','Mrs'],
            ['Miss','Miss']]

  def select_title_values
    options_for_select(TITLE)
  end

  def user_cart
    if user_signed_in?
      current_user.cart.items
    else
      session[:guest_cart]
    end
  end

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
      session[:guest_user]['count'].to_i
    end
  end

  def user_item(id)
    Item.find(id)
  end

  def item_price(item, count)
    item.price * count
  end

  def login_partial
    unless user_signed_in?
      render 'shopping_cart/login'
    end
  end
end
