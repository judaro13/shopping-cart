class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :day_deals

  def day_deals
    @deals = {'panasonic': {url: 'products/panasonic.jpg', price: 400, alt: 'Bootshop panasonoc New camera'}, 'kindle': {url: 'products/kindle.png',  price: 200, alt: 'Bootshop Kindel'}}
  end

end
