require 'test_helper'

class LocationTest < Minitest::Test
  include TrainsOnRails

  def test_new_location
    location = Location.new 'A'
    assert_instance_of Location, location
  end

  def test_any
    refute_equal Location.any?, true
    Location.new 'A'
    Location.new 'B'
    assert_equal Location.any?, true
  end

  def test_locations_storage
    Location.new 'A'
    2.times { Location.new 'B' }
    refute_equal Location.all.size, 3
  end

  def teardown
    Location.clear!
    Trip.clear!
  end
end
