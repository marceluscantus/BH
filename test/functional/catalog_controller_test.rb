#encoding: UTF-8
require File.dirname(__FILE__) + '/../test_helper'  
require 'catalog_controller'

# Re-raise errors caught by the controller.   
class CatalogController; def rescue_action(e) raise e end; end  

class CatalogControllerTest < ActionController::TestCase
  fixtures :manufacturers, :glasses

  setup do
    @controller = CatalogController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "show" do
    get :show, :id => 1
    assert_response :success
    assert_template 'catalog/show'
    assert_equal 'Radial', assigns(:glasses).name
    assert_equal 45.0, assigns(:glasses).price
    assert_tag 'h1', :content => Glasses.find(1).name
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag 'h1', :content => 'Catálogo'
    assert_tag 'a', :content => 'Últimos modelos'
    @glasses = Glasses.find :all, :order => "glasses.id desc"
    pages = @glasses.count / 5
    pages += 1 unless @glasses.count % 5 == 0
    cont = 1
    page = 1
    @glasses.each do |a|
      assert_tag :tag => 'div', :content => a.name
      cont = cont + 1
      if cont > 5 && page < pages  # go to next page
        page = page + 1
        cont = 1
        get :index, :page => page
        assert_response :success
      end
    end
  end

  test "latest" do
    get :latest
    assert_response :success
    assert_tag 'h1', :content => 'Últimos modelos'
    @glasses = Glasses.latest 5
    @glasses.each do |a|
      assert_tag :tag => 'div', :content => a.name
    end
  end
end
