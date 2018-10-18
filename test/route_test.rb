require 'test_helper'

class RouteTest < Minitest::Test
  include TrainsOnRails

  def test_new_route
    route = Route.new 'AB5'
    assert_instance_of Route, route
    assert_equal 'A', route.origin.name
    assert_equal 'B', route.destination.name
    assert_equal 5, route.distance
  end

  def teardown
    Location.clear!
    Trip.clear!
  end
end
