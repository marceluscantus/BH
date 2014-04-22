require File.dirname(__FILE__) + '/../../test_helper'  
require 'admin/glasses_controller'

class Admin::GlassesController; def rescue_action(e) raise e end; end  


class Admin::GlassesControllerTest < ActionController::TestCase
  fixtures :manufacturers, :glasses

  setup do
    @controller = Admin::GlassesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    num_glasses = Glasses.count
    post :create, :glasses => { :glasses_name => 'Radial', :price => 45.5,
    	:manufacturer_id => Manufacturer.find(1).id }
    assert_response :redirect
    assert_redirected_to :action => 'index'
    assert_equal num_glasses + 1, Glasses.count
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag :tag => 'input', :attributes => { :name => 'glasses[glasses_name]',
               :value => 'Radial' }
  end

  test "update" do
    post :update, :id => 1, :glasses => { :glasses_name => 'DeepImpact',
    	 :price => 45.5,
         :manufacturer_id => Manufacturer.find(1).id, 
         }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'DeepImpact', Glasses.find(1).glasses_name
  end

  test "destroy" do
    assert_difference(Glasses, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'Las Gafas Radial han sido eliminadas.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_tag :tag => 'div', :attributes => {:class => 'alert fade in alert-success alert-dismissable'},
                 :content => 'Las Gafas Radial han sido eliminadas.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_response :success
    assert_template 'admin/glasses/show'
    assert_equal 'Radial', assigns(:glasses).name
    assert_tag "h1", :content => Glasses.find(1).glasses_name
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => 'table'
    @glasses = Glasses.find(:all)
    pages = @glasses.count / 5
    pages += 1 unless @glasses.count % 5 == 0
    page = 1
    cont = 1
    @glasses.each do |a|
      assert_tag :tag => 'td', :content => a.glasses_name
      cont = cont + 1
      if cont > 5 && page < pages  # go to next page
        page = page + 1
        cont = 1
        get :index, :page => page
        assert_response :success
      end
    end
  end
end
