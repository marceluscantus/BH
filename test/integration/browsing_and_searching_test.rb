require File.dirname(__FILE__) + '/../test_helper'

class BrowsingAndSearchingTest < ActionDispatch::IntegrationTest
  fixtures :glasses, :manufacturers

  test "browse" do
    jill = new_session_as :jill
    jill.index
    jill.second_page
    jill.glasses_details "Radial"
    jill.latest_glasses
    jill.searches
    #jill.reads_rss
  end

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def index
      get 'catalog/index'
      assert_response :success
      assert_tag :tag => 'p', :content => 'Radial'
      check_glasses_links
    end

    def second_page
      get 'catalog/index?page=1'
      assert_response :success
      assert_template 'catalog/index'
      assert_equal Glasses.find_by_glasses_name("Radial"),
                   assigns(:glasses).last
      check_glasses_links
    end
  end

  def glasses_details(title)
    @glass = Glasses.find_by_glasses_name(title)
    get "catalog/show/#{@glass.id}"
    assert_response :success
    assert_template 'catalog/show'
    assert_tag :tag => 'h1', :content => @glass.glasses_name
    #assert_tag :tag => 'h2', :content => "by #{@glass.manufacturer.map{|a| a.name}.join(", ")}"
  end

  def check_glasses_links
    for glass in assigns :glasses
      assert_tag :tag => 'a', :attributes => { :href => "/catalog/show/#{glass.id}" }
    end
  end

  def latest_glasses
    get 'catalog/latest'
    assert_response :success
    assert_template 'catalog/latest'
    @glasses = Glasses.latest(5)
    @glasses.each do |a|
      assert_tag :tag => 'p', :content => a.glasses_name
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end

  def searches
    #radial = Glasses.find_by_glasses_name("Radial")

    #get "/catalog/search?q=#{url_encode("Radial")}"

    #assert_response :success
    #assert_template "catalog/search"
    #assert_tag :tag => "dl",
    #           :attributes => { :id => "glasses" },
    #           :children => { :count => 1,
    #                          :only => {:tag => "dt"}}

    #radial.glasses.each do |glass|
      #assert_tag :tag => "dt", :content => glass.title
    #end
  end

  def reads_rss
    get "/catalog/rss.xml"
    assert_response :success
    assert_template "catalog/rss"
    assert_equal "application/xml", response.headers["type"]

    assert_tag :tag => "channel",
               :children => { :count => 10,
                              :only => {:tag => "item"}}

    Glasses.latest.each do |glasses|
      assert_tag :tag => "title", :content => glasses.glasses_name
    end
  end

end
