class Station
  attr_reader :trains, :name_station

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
    @trains.delete(train) if @trains.include?(train)
  end
end