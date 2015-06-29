module ShoppingCartHelper
  TITLE = [['Mr','Mr'],
            ['Mrs','Mrs'],
            ['Miss','Miss']]

  def select_title_values
    options_for_select(TITLE)
  end

end
