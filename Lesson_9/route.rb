# frozen_string_literal: true

require_relative 'stations'
require_relative 'instance_counter'
require_relative 'validations'


class Route < Station
  include InstanceCounter
  include Validation

  #superclass_validations
  
  attr_accessor :stations
  attr_reader :start, :finish

  validate :start, :type, Station
  validate :finish, :type, Station

  def initialize(starting_station, ending_station)
    @start = Station.new(starting_station)
    @finish =  Station.new(ending_station)
    validate! 
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
