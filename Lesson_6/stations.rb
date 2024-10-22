require_relative "instance_counter"

class Station
  include InstanceCounter

  attr_reader :trains, :name_station

  @@all_stations = []

  def initialize(name_station)
    @@all_stations << self
    @name_station = name_station
    @trains = []
    register_instance
    validate!
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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected
  
  def validate!
    raise "Запрещено использовать цифры!" if name_station =~ /\d+/
    raise "Строка не должна быть пустой!" if  name_station.empty?
    raise "Название пункта должно состоять из символов на кириллице!" if name_station !~ /^[f-я]+$/i
  end
end