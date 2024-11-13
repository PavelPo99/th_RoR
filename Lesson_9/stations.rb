# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validations'
require_relative 'accessors'


class Station
  include InstanceCounter
  include Validation
  extend Acсessors


  attr_accessor :trains, :name_station
  attr_accessor_with_history :name_station, :trains
  validate :name_station, :presence
  validate :name_station, :format, /\D+/
  validate :name_station, :format, /^[f-я]+$/i


  @@all_stations = []

  def initialize(name_station)
    @name_station = name_station
    validate!
    @@all_stations << self
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
    @trains.select { |train| train.type_train == type }
  end

  def send_train(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def self.all
    @@all_stations
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  def each_train(&block)
    # raise "Не указан блок" unless block_given?

    @trains.each(&block)
  end

  protected

  # def validate!
  #   raise 'Запрещено использовать цифры!' if name_station =~ /\d+/
  #   raise 'Строка не должна быть пустой!' if  name_station.empty?
  #   raise 'Название пункта должно состоять из символов на кириллице!' if name_station !~ /^[f-я]+$/i
  # end
end
