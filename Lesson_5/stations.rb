require_relative "instance_counter"

class Station
  include InstanceCounter

  attr_reader :trains, :name_station

  @@all_stations = []

  def initialize(name_station)
    @@all_stations << self
    @@instances += 1
    @name_station = name_station
    @trains = []
    register_instance
  end

  def add_train_on_station(train)
    @trains << train 
  end

  def show_trains_on_station_now
    @trains
  end

  def type_trains(type)
    @trains.select { |train| train.type_train == type}
  end

  def send_train(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def self.all
    @@all_stations
  end
end