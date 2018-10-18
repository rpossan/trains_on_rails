module TrainsOnRails
  class Routes
    attr_reader :input

    @@routes = []

    def initialize(input = String)
      @input = input
      parse!
    end

    def self.count_routes(trip)
      trip = trip.split('-')
      count = 0
      routes = Routes.where(origin: trip.first)
      destination = trip.last
      routes.each do |from|
        count += 1
        while from.destination.name != destination
          destinations = Routes.where(origin: from.destination.name)
          count += destinations.size
          from = destinations.first
        end
      end
      count + 1
    end

    def self.shortest_distance(origin, destination)
      trips_arr = []
      routes = Routes.where(origin: origin)
      routes.each do |from|
        trips = []
        trips << from.origin.name
        while from.destination.name != destination
          trips << from.destination.name
          destinations = Routes.where(origin: from.destination.name)
          last_shortest = nil
          destinations.each do |d|
            if last_shortest.nil? || last_shortest > d.distance
              last_shortest = d.distance
              from = d
            end
          end
        end
        trips << destination
        trips_arr << trips.join('-')
      end

      total_distances = []
      trips_arr.each do |t|
        begin
          total_distances << Trip.new(t).total_distance
        end
      end
      total_distances.min
    end

    def self.all
      @@routes
    end

    def self.destinations
      all.map(&:destination).map(&:name)
    end

    def self.origins
      all.map(&:origin).map(&:name)
    end

    def self.where(origin:)
      routes = []
      @@routes.each do |r|
        routes << r if r.origin.name == origin
      end
      routes
    end

    def self.find(route)
      points = route.split('-').map(&:strip)
      find_from_origin_and_destination(points.first, points.last)
    end

    def self.find_from_origin_and_destination(origin, destination)
      found = false
      @@routes.each do |r|
        found = r if r.origin.name == origin &&
                     r.destination.name == destination
        break if found
      end
      TrainsError.new(:route_not_found) unless found
      found
    end

    private

    def parse!
      validate!
      @@routes = input.split(', ').map(&:strip)
                      .collect { |route| Route.new route }
    end

    def validate!
      err_msg = 'Invalid Input! Use the format: "AB5, CB6" or "AB5,CB6"'
      TrainsError.new(err_msg) unless valid?
    end

    def valid?
      input.class == String &&
      (/[a-zA-Z][a-zA-Z]([0-9]+,*)/.match? input)
    end
  end
end
