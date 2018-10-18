require 'test_helper'

class TwMainTest < Minitest::Test
  include TrainsOnRails

  @input = Routes.new INPUT

  def test_1_distance
    trip = Trip.new('A-B-C')
    assert_equal trip.total_distance, 9
  end

  def test_2_distance
    trip = Trip.new('A-D')
    assert_equal trip.total_distance, 5
  end

  def test_3_distance
    trip = Trip.new('A-D-C')
    assert_equal trip.total_distance, 13
  end

  def test_4_distance
    trip = Trip.new('A-E-B-C-D')
    assert_equal trip.total_distance, 22
  end

  def test_5_no_such_route
    trip = Trip.new('A-E-D')
    error = assert_raises(TrainsError) { trip.total_distance }
    assert_equal error.message, TrainsError.get_message(:route_not_found)
  end

  def test_6_count_trips
    Trip.new('C-D-C')
    Trip.new('C-E-B-C')
    opts = { origin: 'C', destination: 'C', max_stops: 3 }
    trips = Trip.where(opts)
    assert_equal 2, trips.size
  end

  def test_7_count_trips
    # routes = Routes.new INPUT
    # trip = Trip.make({from: "A", to: "C", start_on: "B"})
    # assert_equal 2, trips.size
  end

  def test_8_shortest_route
    distance = Routes.shortest_distance('A', 'C')
    assert_equal distance, 9
  end

  def test_9_shortest_route
    distance = Routes.shortest_distance('B', 'B')
    assert_equal distance, 9
  end

  def test_10_differents_routes
    trips = [
      'C-D-C', 'C-E-B-C', 'C-E-B-C-D-C', 'C-D-C-E-B-C', 'C-D-E-B-C',
      'C-E-B-C-E-B-C', 'C-E-B-C-E-B-C-E-B-C'
    ]

    trips.each do |t|
      distance = Trip.new(t).total_distance < 30
      assert_equal distance, true
      assert_equal Routes.count_routes(t), 7
    end
  end

  def distance_less_than(distance, val)
    distance < val
  end

  def teardown
    Location.clear!
    Trip.clear!
  end
end
