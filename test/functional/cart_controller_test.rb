require 'test_helper'
require 'cart_controller'

# Re-raise errors caught by the controller.   
class CartController; def rescue_action(e) raise e end; end

class CartControllerTest < ActionController::TestCase
  fixtures :manufacturers, :glasses

  setup do
    @controller = CartController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "add" do
    assert_difference(CartItem, :count) do
      post :add, :id => 3
    end
    assert_response :redirect
    assert_redirected_to :controller => 'catalog'
    assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  end

  test "remove" do
    post :add, :id => 2
    assert_equal [Glasses.find(2)], Cart.find(@request.session[:cart_id]).glasses

    post :remove, :id => 2
    assert_equal [], Cart.find(@request.session[:cart_id]).glasses
  end

  test "clear" do
    post :add, :id => 2
    assert_equal [Glasses.find(2)], Cart.find(@request.session[:cart_id]).glasses

    post :clear
    assert_response :redirect
    assert_redirected_to :controller => 'catalog'
    assert_equal [], Cart.find(@request.session[:cart_id]).glasses
  end
end
