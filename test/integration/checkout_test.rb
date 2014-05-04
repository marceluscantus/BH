# encoding: UTF-8
require File.dirname(__FILE__) + '/../test_helper'

class CheckoutTest < ActionDispatch::IntegrationTest
  fixtures :manufacturers, :glasses
  test "empty_cart_shows_error_message" do
    get '/checkout'
    assert_response :redirect
    assert_redirected_to :controller => 'catalog'
    assert_equal flash[:notice], 'El carro está vacío! ' +
                                 'Por favor, añada algún artículo antes de procesar su pedido.'
  end

  test "submitting_order" do
    post '/cart/add', :id => 1
    get '/checkout'
    assert_response :success
    assert_tag :tag => 'legend', :content => 'Información de contacto'
    assert_tag :tag => 'legend', :content => 'Dirección de envío'
    assert_tag :tag => 'legend', :content => 'Información de pago'

    post '/checkout/submit_order', :cart => { :id => Cart.last.id }, :order => {
      # Contact information
      :email => 'email@email.com',
      :phone_number => '666112233',
      # Shipping address
      :ship_to_first_name => 'Nombre',
      :ship_to_last_name => 'Apellidos',
      :ship_to_address => 'Dirección',
      :ship_to_city => 'Ciudad',
      :ship_to_postal_code => '00000',
      :ship_to_country_code => 'País',
      # Billing information
      :card_type => 'Visa',
      :card_number => '4007000000027',
      :card_expiration_month => '3',
      :card_expiration_year => '2018',
      :card_verification_value => '000'
    }

    assert_response :redirect
    assert_redirected_to '/checkout/thank_you'
  end
end
