module TrainsOnRails
  class Location
    attr_accessor :name

    @@locations = []

    def initialize(name)
      @name = name
      @@locations << self unless Location.any?(name)
    end

    def self.clear!
      @@locations.clear
    end

    def self.all
      @@locations
    end

    def self.find_or_create(name)
      any?(name) ? find(name) : new(name)
    end

    def self.find(name)
      index = @@locations.map(&:name).index(name)
      return false if index.nil?
      @@locations[index]
    end

    def self.any?(loc_name = nil)
      return @@locations.any? if loc_name.nil?
      @@locations.map(&:name).include? loc_name
    end
  end
end
