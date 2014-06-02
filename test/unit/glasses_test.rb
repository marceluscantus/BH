require File.dirname(__FILE__) + '/../test_helper'

class GlassesTest < ActiveSupport::TestCase
  fixtures :manufacturers, :glasses

  test "failing_create" do
    glasses = Glasses.new
    assert_equal false, glasses.save
    assert_equal 3, glasses.errors.count
    assert glasses.errors[:glasses_name]
    assert glasses.errors[:price]
    assert glasses.errors[:manufacturer]
  end

  test "create" do
    glasses = Glasses.new(
      :glasses_name => 'RoR',
      :price => 55.9,
      :manufacturer_id => Manufacturer.find(1).id,
    )
  assert glasses.save
  end

  test "belongs_to_mapping" do
    arnette = Manufacturer.find_by_company_name("Arnette");
    count = arnette.glasses.count
    glasses = Glasses.new(
      :glasses_name => 'Radial',
      :price => 55.5,
      :manufacturer_id => arnette.id  
    )
    arnette.glasses << glasses
    arnette.reload
    glasses.reload
    assert_equal count + 1, arnette.glasses.count
    assert_equal 'Arnette', glasses.manufacturer.name
  end

  def test_ferret
      #Glasses.rebuild_index
      #assert Glasses.find_with_ferrets("Radial")
      
      #assert_difference Glasses, :count do
        #glasses = Glasses.new(:glasses_name => 'V8', :price => 59.99)
        #glasses.manufacturer_id << Manufacturer.create(:company_name => "D&G", :city => "Manhatan", :telephone => 934567890, :mail => "contact@dandg.com", :address => "Avenue SunGlasses 1")
        #glasses.manufacturer_id = Manufacturer.find(1)
        #assert glasses.valid?
        #glasses.save
        #assert_equal 1, Glasses.find_with_ferrets("v8").size
        #assert_equal 1, Glasses.find_with_ferrets("D&G").size
      #end
  end

end