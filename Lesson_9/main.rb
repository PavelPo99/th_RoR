# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'route'
require_relative 'stations'
#require "byebug"

class Main
  MENU = [
    { id: 1, title: 'Создать станцию', action: :create_station },
    { id: 2, title: 'Создать поезд', action: :create_train },
    { id: 3, title: 'Создать маршруты / управлять станциями', action: :create_route_or_menagment_station },
    { id: 4, title: 'Назначить маршрут поезду', action: :assign_route },
    { id: 5, title: 'Добавить вагоны к поезду', action: :add_wagon_to_train },
    { id: 6, title: 'Отцепить вагоны от поезда', action: :delete_wagon },
    { id: 7, title: 'Переместить поезд по маршруту', action: :move_train_along_the_route },
    { id: 8, title: 'Просмoтреть список станций и список поездов на станции',
      action: :list_of_station_and_list_of_train },
    { id: 9, title: 'Управление вагонами поезда', action: :train_car_management }
  ].freeze

  attr_reader :trains, :routes, :stations

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      menu
      choice = gets.chomp.to_i
      if choice.zero?
        break
      elsif (1..9).to_a.include?(choice)
        send(MENU[choice - 1][:action])
      else
        puts 'Такого пункта не существует!'
      end
    end
  end

  def menu
    puts ''
    puts '--------------------------------------------'
    MENU.each { |value| puts "#{value[:id]}. #{value[:title]}" }
    puts '0. - Выйти'
  end

  # Все методы работы с поездом и вагонами
  def create_train
    attempt = 0

    begin
      puts "\nВыберите тип поезда: \n1. Пассажирский поезд. \n2. Грузовой поезд"
      choose_type = gets.chomp
      raise 'Такого пункта не существует!' if choose_type !~ /(1|2)/

      puts 'Впишите номер поезда:'
      id_train = gets.chomp.to_s

      @trains << if choose_type.to_i == 1
                   PassengerTrain.new(id_train)
                 else
                   CargoTrain.new(id_train)
                 end

      puts "Создан #{choose_type == 1 ? 'Пассажирский' : 'Грузовой'} поезд с номером: #{id_train}"
    rescue RuntimeError => e
      puts e
      attempt += 1
      retry if attempt < 4

      puts 'Лимит попыток превышен!'
    end
  end

  def choose_train
    @trains.each_with_index do |value, index|
      puts "#{index + 1}. Номер: #{value.id_train}    тип: #{value.type_train}"
    end
  end

  def current_train(num_train)
    @trains[num_train - 1]
  end

  def create_wagon
    loop do
      puts "Выберите нужный пункт:\n1. Создать пассажирски вагон.\n2. Создать грузовой вагон.\n0. Выйти."
      choice = gets.chomp.to_i

      case choice
      when 1
        puts 'Укажите колличество мест:'
        seats = gets.chomp.to_i

        return WagonPassenger.new(seats)
      when 2
        puts 'Укажите объем вагона:'
        volume = gets.chomp.to_i

        return WagonCargo.new(volume)
      when 0
        break
      else
        puts 'Такого пункта не существует!'
      end
    end
  end

  def add_wagon_to_train
    loop do
      puts 'Выберите нужный пункт:'
      puts '1. Создать вагон'
      puts '0. Выйти.'

      choice = gets.chomp.to_i

      if choice == 1
        wagon = create_wagon

        puts 'Выберите поезд к которому прицепить вагон: '

        choose_train

        num_train = gets.chomp.to_i

        current_train(num_train).add_wagon(wagon)
      elsif choice.zero?
        break
      else
        puts 'Такой пункт меню отсутствует!'
      end
    end
  end

  def delete_wagon
    puts 'Выберите поезд от которого хотите отцепить вагон: '

    choose_train
    num_train = gets.chomp.to_i

    puts 'Выберите какой хотите отцепить вагон: '
    current_train(num_train).show_wagons.each_with_index do |wagon, index|
      print " #{index + 1}: #{wagon}, тип: #{wagon.type}\n"
    end

    del_wagon = gets.chomp.to_i
    current_train(num_train).subtract_wagon(current_train(num_train).show_wagons[del_wagon - 1])
  end

  def move_train_along_the_route
    puts 'Какой поезд хотите перемещать?'
    choose_train
    num_train = gets.chomp.to_i

    loop do
      puts "\n1. Посмотреть маршрутную карту.\n2. Переместить поезд на следующую станцию.\n3. Переместить поезд на предыдущую станцию.\n0. Выйти"
      gets_job = gets.chomp.to_i

      case gets_job
      when 1
        current_train(num_train).show_stations.each { |station| print "#{station.name_station} - " }
      when 2
        current_train(num_train).move_forward
        puts "Поезд #{current_train(num_train).id_train} находится на станции: #{current_train(num_train).current_station.name_station}"
      when 3
        current_train(num_train).move_backward
        puts "Поезд #{current_train(num_train).id_train} находится на станции: #{current_train(num_train).current_station.name_station}"
      when 0
        break
      else
        puts 'Такой пункт меню отсутствует!'
      end
    end
  end

  # Все методы работы со станциями и маршрутами

  def assign_route
    puts 'Выберите маршрут который хотите назначить:'
    choose_route
    gets_route = gets.chomp.to_i

    puts 'Выберите поезд к которому хотите назначить маршрут: '
    choose_train
    num_train = gets.chomp.to_i

    current_train(num_train).route(@routes[gets_route - 1])

    puts "Поезду '#{current_train(num_train).id_train}' назначен маршрут: '#{@routes[gets_route - 1].stations.first.name_station}-#{@routes[gets_route - 1].stations.last.name_station}'"
  end

  def create_route_or_menagment_station
    loop do
      puts "Выберете: \n1. Создать маршрут."
      puts '2. Управлять станциями.' unless @routes.empty?
      puts '0. Выйти.'
      choice = gets.chomp.to_i

      case choice
      when 1
        create_route
      when 2
        management_route
      when 0
        break
      else
        puts 'Такой пункт меню отсутствует!'
      end
    end
  end

  def create_route
    attempt = 0

    begin
      puts 'Для создания маршрута, напишите начальную станцию:'
      starting_station = gets.chomp.to_s
      puts 'Затем конечную станцию:'
      ending_station = gets.chomp.to_s
      @routes << Route.new(starting_station, ending_station)
      puts "\nСоздан маршрут: #{@routes.last.stations.first.name_station}-#{@routes.last.stations.last.name_station}"
    rescue RuntimeError => e
      puts e
      attempt += 1
      retry if attempt < 4

      puts 'Лимит попыток превышен!'
    end
  end

  def management_route
    puts 'Выберете маршрут: '

    choose_route

    choosing_route = gets.chomp.to_i

    puts '1. Добавить промежуточную станцию.'
    puts '2. Удалить промежуточную станцию.' if @routes[choosing_route - 1].stations.length > 2
    puts '0. Выйти.'
    choosing_station_management = gets.chomp.to_i

    if choosing_station_management == 1
      puts 'Выберите станцию которую хотите добавить:'
      chooce_station
      num_station = gets.chomp.to_i

      @routes[choosing_route - 1].add_intermediate_station(@stations[num_station - 1])
    elsif choosing_station_management == 2
      puts 'Выберете станцию которую хотите удалить: '
      count = 0
      @routes[choosing_route - 1].stations.each do |value|
        if value != @routes[choosing_route - 1].stations.first && value != @routes[choosing_route - 1].stations.last
          puts "#{count += 1}. #{value.name_station}"
        end
      end
      num_station = gets.chomp.to_i

      @routes[choosing_route - 1].delete_station(@routes[choosing_route - 1].stations[num_station])
    else
      puts 'Такой пункт меню отсутствует!'
    end
  end

  def choose_route
    @routes.each_with_index do |value, index|
      puts "#{index + 1}. #{value.stations.first.name_station}-#{value.stations.last.name_station}"
    end
  end

  def create_station
    attempt = 0

    begin
      puts 'Напишите название станции:'
      name_station = gets.chomp.to_s
      @stations << Station.new(name_station)
      puts "Станция '#{name_station}' создана."
    rescue RuntimeError => e
      puts e
      attempt += 1
      retry if attempt < 4

      puts 'Лимит попыток превышен!'
    end
  end

  def chooce_station
    count = 1
    @stations.each do |value|
      puts "#{count}. #{value.name_station}"
      count += 1
    end
  end

  def list_of_station_and_list_of_train
    chooce_station
    puts 'Выберите станцию для вывода списка поездов на станции:'
    gets_job = gets.chomp.to_i
    @stations[gets_job - 1].each_train do |train|
      puts "На станции '#{@stations[gets_job - 1].name_station}' находится поезд: '#{train.id_train}'"
    end
  end

  def takes_volume_cargo_wagon(num_train)
    puts 'Выберите номер вагона:'
    num_wagon = gets.chomp.to_i
    current_wagon = current_train(num_train).wagons[num_wagon - 1]

    puts 'Какой объем заполнить?'
    volume = gets.chomp.to_i
    current_wagon.takes_volume(volume)
    puts "В вагоне #{current_wagon}, свободный объем состовляет: #{current_wagon.free_volume}"
  end

  def used_volume_cargo_wagon(num_train)
    puts 'Выберите номер вагона:'
    num_wagon = gets.chomp.to_i
    current_wagon = current_train(num_train).wagons[num_wagon - 1]
    puts "Вагоне #{current_wagon}, занятый объем состовляет: #{current_wagon.used_volume}"
  end

  def free_volume_cargo_wagon(num_train)
    puts 'Выберите номер вагона:'
    num_wagon = gets.chomp.to_i
    current_wagon = current_train(num_train).wagons[num_wagon - 1]
    puts "В вагоне #{current_wagon}, свободный объем состовляет: #{current_wagon.free_volume}"
  end

  def takes_seat_passenger_wagon(num_train)
    puts 'Выберите номер вагона:'
    num_wagon = gets.chomp.to_i
    current_wagon = current_train(num_train).wagons[num_wagon - 1]
    current_wagon.takes_seat
    puts "Вы заняли место в вагоне #{current_wagon}!"
  end

  def used_volume_passenger_wagon(num_train)
    puts 'Выберите номер вагона:'
    num_wagon = gets.chomp.to_i
    current_wagon = current_train(num_train).wagons[num_wagon - 1]
    puts "В вагоне #{current_wagon} занято мест: #{current_wagon.used_volume}"
  end

  def free_volume_passenger_wagon(num_train)
    puts 'Выберите номер вагона:'
    num_wagon = gets.chomp.to_i
    current_wagon = current_train(num_train).wagons[num_wagon - 1]
    puts "В вагоне #{current_wagon} осталось мест: #{current_wagon.free_volume}"
  end

  def list_train_wagons(num_train)
    puts "Список вагонов поезда #{current_train(num_train).id_train}: "
    num = 0
    current_train(num_train).each_wagon do |wagon|
      print "#{num += 1}: #{wagon} - "
    end
  end

  def train_car_management
    loop do
      puts "\nВыберите номер поезд:"
      choose_train
      num_train = gets.chomp.to_i

      if current_train(num_train).wagons.empty?
        puts "В поезде #{current_train(num_train)} отсутсвуют вагоны!"
        break
      elsif current_train(num_train).type_train == :cargo

        list_train_wagons(num_train)

        puts "\nВыберите действие:\n1. Заполнить вагон.\n2. Показать занятый объем.\n3. Показать свободный объем."
        choice = gets.chomp.to_i

        case choice
        when 1
          takes_volume_cargo_wagon(num_train)
          break
        when 2
          used_volume_cargo_wagon(num_train)
          break
        when 3
          free_volume_cargo_wagon(num_train)
          break
        else
          puts 'Такой пункт меню отсутствует!'
        end

      elsif current_train(num_train).type_train == :passenger

        list_train_wagons(num_train)

        puts "\nВыберите действие:\n1. Занять место в вагоне.\n2. Показать кол-во занятых мест в вагоне.\n3. Показать кол-во свободных мест в вагоне."
        choice = gets.chomp.to_i

        case choice
        when 1
          takes_seat_passenger_wagon(num_train)
          break
        when 2
          used_volume_passenger_wagon(num_train)
          break
        when 3
          free_volume_passenger_wagon(num_train)
          break
        else
          puts 'Такой пункт меню отсутствует!'
        end
      else
        puts 'Такой пункт меню отсутствует!'
      end
    end
  end
end

n = Main.new
n.start
