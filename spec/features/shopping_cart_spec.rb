require 'spec_helper'

feature 'ShoppingCart', :js => true do

  context "Customer" do
    scenario 'login' do
      visit root_path
      first(:href, '#login').click
      fill_in 'user_email', with: 'test@email.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      expect(page).to have_text('Signed in successfully.')    
    end

    scenario 'login from cart' do
      visit root_path
      item = Item.first
      first(:href, add_to_cart_path(item_id: item.id)).click

      visit cart_path

      expect(page).to have_text('Register Now!') 

      fill_in 'user_email', with: 'test@email.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      expect(page).to have_text('Signed in successfully.')  
      expect(page).to have_text('SHOPPING CART')
    end

    scenario 'login with items in cart' do
      visit root_path
      item = Item.first
      first(:href, add_to_cart_path(item_id: item.id)).click

      first(:href, '#login').click
      fill_in 'user_email', with: 'test@email.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      expect(page).to have_text('Signed in successfully.')
      expect(page).to have_text('1 Items')      
    end

    scenario 'go to cart without items' do
      visit cart_path
      expect(page).to have_text('SHOPPING CART')
      expect(page).to have_text("You don't have any items in your cart")      
    end

    context 'Cart' do
      before do
        visit root_path
        @item1 = Item.first

        first(:href, add_to_cart_path(item_id: @item1.id)).click
        first(:href, add_to_cart_path(item_id: @item1.id)).click

        first(:href, '#login').click
        fill_in 'user_email', with: 'test@email.com'
        fill_in 'user_password', with: 'password'
        click_button 'Log in'

        visit cart_path
        expect(page).to have_text('SHOPPING CART')
      end

      scenario 'add more of same item' do
        first(:href, add_to_cart_path(item_id: @item1.id)).click
        wait_for_ajax
        expect(page).to have_text("#{@item1.price.to_f * 3}")
      end

      scenario 'remove single item' do
        first(:href, remove_from_cart_path(item_id: @item1.id)).click
        wait_for_ajax
        expect(page).to_not have_text("#{@item1.price.to_f * 2}")
      end

      scenario 'remove all same items' do
        first(:href, remove_from_cart_path(item_id: @item1.id, count: 1)).click
        expect(page).to_not have_text("#{@item1.price.to_i * 2}")
      end

      scenario 'remove all items' do
        first(:href, clean_cart_path).click
        wait_for_ajax
        expect(page).to have_text("You don't have any items in your cart")    
      end
    end
  end

  context "Guest User" do
    scenario 'Visiting index' do
      visit root_path
      expect(page).to have_text('Hi Guest')
      expect(page).to have_link('Login', href: '#login')
    end

    scenario 'add item to cart' do
      visit root_path
      item = Item.first
      first(:href, add_to_cart_path(item_id: item.id)).click
      expect(page).to have_text('1 Items')
    end

    scenario 'sign in' do
      visit new_user_registration_path
      expect(page).to have_text('Registration')
      select 'Mr', :from => 'user_title'
      fill_in 'user_first_name', with: 'jhon'
      fill_in 'user_last_name', with: 'doe'
      fill_in 'user_email', with: 'test2@email.com'
      fill_in 'user_password', with: 'some_password'
      fill_in 'user_password_confirmation', with: 'some_password'
      fill_in 'user_address_attributes_first_name', with: 'jhon'
      fill_in 'user_address_attributes_last_name', with: 'doe'
      fill_in 'user_address_attributes_address', with: 'some address'
      fill_in 'user_address_attributes_address_complement', with: 'some apt'
      fill_in 'user_address_attributes_city', with: 'Cuba'
      fill_in 'user_address_attributes_state', with: 'Cuba'
      fill_in 'user_address_attributes_country', with: 'Cuba'
      fill_in 'user_address_attributes_zip_code', with: 1100111
      fill_in 'user_address_attributes_home_phone', with: 301356
      click_button 'Sign up'

      expect(page).to have_text('Welcome! You have signed up successfully.')
    end
  


    scenario 'sign in with errors' do
      visit new_user_registration_path
      expect(page).to have_text('Registration')
      select 'Mr', :from => 'user_title'
      fill_in 'user_first_name', with: 'jhon'
      fill_in 'user_email', with: 'test2@email.com'
      fill_in 'user_password', with: 'some_password'
      fill_in 'user_password_confirmation', with: 'some_password'
      fill_in 'user_address_attributes_first_name', with: 'jhon'
      fill_in 'user_address_attributes_last_name', with: 'doe'
      fill_in 'user_address_attributes_address', with: 'some address'
      fill_in 'user_address_attributes_address_complement', with: 'some apt'

      click_button 'Sign up'
      expect(page).to have_text('2 errors prohibited this user from being saved')
      expect(page).to have_text('Address is invalid')
      expect(page).to have_text("Last name can't be blank")
    end

   scenario 'sign in with items in cart' do
      visit root_path
      item = Item.first
      first(:href, add_to_cart_path(item_id: item.id)).click

      first(:href, new_user_registration_path).click
      
      expect(page).to have_text('Registration')
      select 'Mr', :from => 'user_title'
      fill_in 'user_first_name', with: 'jhon'
      fill_in 'user_last_name', with: 'doe'
      fill_in 'user_email', with: 'test2@email.com'
      fill_in 'user_password', with: 'some_password'
      fill_in 'user_password_confirmation', with: 'some_password'
      fill_in 'user_address_attributes_first_name', with: 'jhon'
      fill_in 'user_address_attributes_last_name', with: 'doe'
      fill_in 'user_address_attributes_address', with: 'some address'
      fill_in 'user_address_attributes_address_complement', with: 'some apt'
      fill_in 'user_address_attributes_city', with: 'Cuba'
      fill_in 'user_address_attributes_state', with: 'Cuba'
      fill_in 'user_address_attributes_country', with: 'Cuba'
      fill_in 'user_address_attributes_zip_code', with: 1100111
      fill_in 'user_address_attributes_home_phone', with: 301356
      click_button 'Sign up'

      expect(page).to have_text('Welcome! You have signed up successfully.')
      expect(page).to have_text('1 Items')
    end
    
    scenario 'go to cart without items' do
      visit cart_path
      expect(page).to have_text('SHOPPING CART')
      expect(page).to have_text("You don't have any items in your cart")      
    end

  end

end
