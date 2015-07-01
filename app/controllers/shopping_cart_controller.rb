class  ShoppingCartController < ApplicationController
  def index
  end

  def cart
  end


  def remove_from_cart
    user_add_to_cart(params['item_id'], 1)
    respond_to do |format|
      format.js
    end
  end

  def add_to_cart
    user_add_to_cart(params['item_id'], 1)
    respond_to do |format|
      format.js
    end
  end

  def clean_cart
    if current_user
      current_user.cart.clean
    else
      session[:guest_user] = {total: 0.0, count: 0}
      session[:guest_cart] = {} 
    end
    
    respond_to do |format|
      format.js
    end
  end

  private
  def user_add_to_cart(item_id, item_count)
    if user_signed_in?
      current_user.cart.add_item(item_id, item_count)
    else
      add_item_to_cart(item_id, item_count)
    end
  end

  def user_remove_from_cart(item_id, item_count)
    if user_signed_in?
      current_user.cart.remove_item(item_id, item_count)
    else
      remove_item_from_cart(item_id, item_count)
    end
  end

  def add_item_to_cart(item_id, item_count)
      item = Item.find(item_id)
      session[:guest_user]['total'] += item.price * item_count
      session[:guest_user]['count'] += item_count

      #splited for not writte a long line
      count = session[:guest_cart][item_id.to_s].to_i 
      session[:guest_cart][item_id.to_s] = count + item_count
  end

  def remove_item_from_cart(item_id, item_count)
      item = Item.find(item_id)
      session[:guest_user]['total'] -= item.price * item_count
      session[:guest_user]['count'] -= item_count
      count = session[:guest_cart][item_id.to_s].to_i - item_count

      if count <= 0
        session[:guest_cart].dete(item_id.to_s)
      else
        session[:guest_cart][item_id.to_s] = count
      end
  end
end
