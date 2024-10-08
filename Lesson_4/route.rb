require_relative "stations"

class Route < Station
  attr_accessor :stations

  def initialize(starting_station, ending_station)
    start = Station.new(starting_station)
    finish =  Station.new(ending_station)
    @stations = [start, finish]
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