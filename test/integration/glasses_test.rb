require File.dirname(__FILE__) + '/../test_helper'

class GlassesTest < ActionDispatch::IntegrationTest
  test "glasses_administration" do
    manufacturer = Manufacturer.create(:company_name => 'Otoole')
    george = new_session_as(:george)
    puts manufacturer.id
    new_glasses_ruby = george.add_glasses :glasses => {
      :glasses_name => 'New Melon model',
      :price => 23.15,
      :manufacturer_id => manufacturer.id
  }
    puts new_glasses_ruby
    george.list_glasses
    george.show_glasses new_glasses_ruby

    george.edit_glasses new_glasses_ruby, :glasses => {
      :glasses_name => 'Super New Melon model',
      :manufacturer_id => manufacturer.id,
      :price => 50,
      :description => 'A new glasses of Melon'
    }

    bob = new_session_as(:bob)
    bob.delete_glasses new_glasses_ruby
  end

  private

  module GlassesTestDSL
    attr_writer :name

    def add_glasses(parameters)
      manufacturer = Manufacturer.find(:all).first
      get 'admin/glasses/new'
      assert_response :success
      assert_template 'admin/glasses/new'
      assert_tag :tag => 'option', :attributes => { :value => manufacturer.id }
      post 'admin/glasses/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/glasses/index'
      page = Glasses.find(:all).count / 5 + 1
      get "admin/glasses/index/?page=#{page}"
      assert_tag :tag => 'td', :content => parameters[:glasses][:name]
      glasses = Glasses.find_by_glasses_name(parameters[:glasses][:name])
      return glasses;
    end

    def edit_glasses(glasses, parameters)
      get "admin/glasses/edit?id=#{glasses.id}"
      assert_response :success
      assert_template 'admin/glasses/edit'
      post "admin/glasses/update?id=#{glasses.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/glasses/show'
    end

    def delete_glasses(glasses)
      post "admin/book/destroy?id=#{glasses.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/glasses/index'
    end

    def show_glasses(glasses)
      get "admin/glasses/show/#{glasses.id}"
      assert_response :success
      assert_template 'admin/glasses/show'
    end

    def list_glasses
      get 'admin/glasses/index'
      assert_response :success
      assert_template 'admin/glasses/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(GlassesTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end