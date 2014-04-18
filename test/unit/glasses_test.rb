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

end