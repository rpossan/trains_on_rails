require 'test_helper'
class RoutesTest < Minitest::Test
  include TrainsOnRails

  Routes.new INPUT

  def error_message
    'Invalid Input! Use the format: "AB5, CB6" or "AB5,CB6"'
  end

  def test_all_routes
    assert_instance_of Array, Routes.all
  end

  def test_find_routes
    route = Routes.find('A-B')
    assert_instance_of Route, route
    assert_equal 'A', route.origin.name
    assert_equal 'B', route.destination.name
  end

  def test_no_such_routes
    error = assert_raises(TrainsError) { Routes.find('X-Y') }
    assert_equal error.message, TrainsError.get_message(:route_not_found)
  end

  def test_invalid_format
    routes = [nil, 123, 'X1']

    routes.each do |route|
      error = assert_raises(TrainsError) { Routes.new route }
      assert_equal error.message, error_message
    end
  end

  def teardown
    Location.clear!
    Trip.clear!
  end
end
