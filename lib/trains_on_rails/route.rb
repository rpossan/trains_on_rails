module TrainsOnRails
  class Route
    attr_accessor :origin, :destination, :distance

    def initialize(route)
      parse! route
    end

    private

    def parse!(route)
      @origin = Location.find_or_create route[0]
      @destination = Location.find_or_create route[1]
      @distance = route[2..route.size].to_i
    end
  end
end
