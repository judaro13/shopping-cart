class  ShoppingCartController < ApplicationController
  def index
    @feature_products = Item.all.limit(16)
    @lasted_products = Item.all.asc.limit(16)
    render layout: 'welcome'
  end
end
