require_relative "stations"
require_relative "instance_counter"

class Route < Station
  include InstanceCounter
  attr_accessor :stations

  def initialize(starting_station, ending_station)
    start = Station.new(starting_station)
    finish =  Station.new(ending_station)
    @stations = [start, finish]
    register_instance
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(@stations[1..-2].delete(station)) 
  end
  

  def show_stations
    @stations
  end 

end