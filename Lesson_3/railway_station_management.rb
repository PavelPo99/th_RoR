class Station
  attr_reader :trains

  def initialize(name_station)
    @name_station = name_station
    @trains = []
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
    @trains.delete(train)
  end
end


class Route
  attr_reader :stations

  def initialize(starting_station, ending_station)
    @stations = [starting_station, ending_station]
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def delete_intermediate_station(station)
    @stations[1..-2].delete(station)
    puts "Была удалена станция: '#{station}' из списка промежуточных станций"
  end

  def show_stations
    @stations
      
    id = 1

    @stations.each do |station|
      puts "#{id}: #{station}"
      id += 1
    end
  end 
end


class Train
  attr_reader :correct_station, :type_train

  def initialize(number_train, type_train, numbers_of_wagons)
    @number_train = number_train
    @type_train = type_train
    @numbers_of_wagons = numbers_of_wagons
    @speed = 0
  end

  def start(value)
    @speed += value
    puts "Поезд набирает скорость до #{@speed} км/ч"
  end

  def current_speed
    puts "Текущая скорость поезда равна: #{@speed} км/ч"
  end

  def stop
    @speed = 0
    puts "Поезд сбрасывает скорость до нуля!"
  end

  def show_wagons
    puts "Количество вагонов: #{@numbers_of_wagons}"
  end

  def add_wagon
    @numbers_of_wagons += 1 if @speed == 0
    puts "Поезд пристыковал вагон!"
  end

  def subtract_wagon
    @numbers_of_wagons -= 1 if @speed == 0 && @numbers_of_wagons > 0
    puts "Поезд отстыковал вагон!"
  end

  def route(class_route)
    @stations = class_route.stations
    @correct_station = class_route.stations[0]
  end
  
  def move_forward
    @correct_station = @stations[@stations.index(@correct_station) + 1] if @correct_station == @stations.last
    puts @correct_station
  end

  def move_backward
    @correct_station = @stations[@stations.index(@correct_station) - 1] if @correct_station != @stations[0]
    puts @correct_station
  end

  def next_station
    @stations[@stations.index(@correct_station) + 1] if @correct_station == @stations.last
  end

  def current_station
    @correct_station 
  end

  def previous_station
    @stations[@stations.index(@correct_station) - 1] if @correct_station != @stations[0]
  end
end
