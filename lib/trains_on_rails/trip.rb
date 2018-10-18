module TrainsOnRails
  class Trip
    attr_accessor :trip, :points

    @@trips = []

    def initialize(trip)
      @trip = trip
      validate!
      @points = trip.split('-')
      @@trips << @points
    end

    def total_distance
      total = 0
      points.each_with_index do |p, index|
        break if index == points.size - 1
        route = "#{p}-#{points[index + 1]}"
        total += Routes.find(route).distance
      end
      total
    end

    def self.routes(from:, to:, start_on: nil)
      trip = []
      initial = start_on.nil? ? from : start_on
      route = Routes.where(origin: initial).first
      trip << route.origin.name
      dest = from
      while route.destination.name != dest
        route = Routes.where(origin: route.destination.name)
        trip << route.origin.name
        dest = to if dest == from
      end
    end

    def self.where(origin:, destination:, max_stops:)
      found = []
      @@trips.each do |trip|
        num_stops = stops(trip.join('-')).size
        checked = check_origin_destination(trip, origin, destination)
        found << trip if checked && num_stops <= max_stops
      end
      found
    end

    def self.clear!
      @@trips.clear
    end

    def self.stops(route)
      route.split('-').drop(1)
    end

    def self.check_origin_destination(trip, origin, destination)
      trip.first == origin && trip.last == destination
    end

    private

    def validate!
      err_msg = 'Invalid Input! Use the format: "A-B-C"'
      TrainsError.new(err_msg) unless valid?
    end

    def valid?
      trip.class == String &&
      (/[A-Z]-*/.match? trip)
    end
  end
end
