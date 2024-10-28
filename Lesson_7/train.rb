require_relative 'company_name'
require_relative "instance_counter"

class Train
  include CompanyName
  include InstanceCounter

  attr_reader :speed, :wagons, :type_train, :id_train

  @@all_trains = []
  NUM_TRAIN = /^\w{3}(-|\s)\w{2}$/

  def initialize(id_train, type_train)
    @id_train = id_train
    @type_train = type_train
    validate!
    @speed = 0
    @wagons = []
    @@all_trains << self
    register_instance
  end

  def start(value)
    @speed += value  
  end

  def stop
    @speed = 0 if @speed != 0
  end

  def current_speed
    @speed
  end


  def show_wagons
    @wagons
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && valid_wagon?(wagon)
  end

  def subtract_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero? && wagons.include?(wagon)
  end

  
  def route(class_route)
    @stations = class_route.stations
    @correct_station = class_route.stations[0]
    @correct_station.add_train_on_station(self)
  end
 
  def move_forward
    @correct_station.send_train(self)
    @correct_station = next_station
    @correct_station.add_train_on_station(self)
  end

  def move_backward
    @correct_station.send_train(self)
    @correct_station = previous_station
    @correct_station.add_train_on_station(self)
  end

  def next_station
    @stations[@stations.index(@correct_station) + 1] if @correct_station != @stations.last
  end

  def current_station
    @correct_station 
  end

  def show_stations
    @stations  
  end


  def previous_station
    @stations[@stations.index(@correct_station) - 1] if @correct_station != @stations[0]
  end

  def self.find(num_train)
    @@all_trains.each do |train|
      return train if train.id_train.to_s == num_train.to_s
    end
    nil 
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def each_wagon(&block)
    @wagons.each(&block)
  end

  protected
  
  def validate!
    raise "Строка не должна быть пустой!" if  id_train.empty?
    raise "Недопустимый формат!\nФормат: три буквы/цифры, дефис или пробел, 2 буквы/цифры!" if id_train !~ NUM_TRAIN
  end

  # делаем невидимым метод valid_wagon?, так как он кроме класса Train нигде не используется и не должен использоваться
  private

  def valid_wagon?(wagon)
    @type_train == wagon.type
  end

end