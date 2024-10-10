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
      if choice == 0
        break
      else
        action = MENU[choice-1][:action]
        send(action)
      end
    end
  end


  MENU = [
    {id: 1, title: "Создать станцию", action: :create_station },
    {id: 2, title: "Создать поезд", action: :create_train },
    {id: 3, title: "Создать маршруты / управлять станциями", action: :create_route_or_menagment_station },
    {id: 4, title: "Назначить маршрут поезду", action: :assign_route },
    {id: 5, title: "Добавить вагоны к поезду", action: :add_wagon_to_train },
    {id: 6, title: "Отцепить вагоны от поезда", action: :delete_wagon },
    {id: 7, title: "Переместить поезд по маршруту", action: :move_train_along_the_route },
    {id: 8, title: "Просмoтреть список станций и список поездов на станции", action: :list_of_station_and_list_of_train }
  ]


  def menu
    puts ""
    puts "--------------------------------------------"
    MENU.each { |value| puts "#{value[:id]}. #{value[:title]}"}
    puts "0. - Выйти"
  end


  # Все методы работы с поездом и вагонами
  def create_train
    puts "Выберите тип поезда: \n1. Пассажирский поезд. \n2. Грузовой поезд"
    choose_type = gets.chomp.to_i
    puts "Впишите номер поезда:" 
    id_train = gets.chomp.to_s

    case choose_type
    when 1
      train = PassengerTrain.new(id_train) 
    when 2
      train = CargoTrain.new(id_train) 
    else
      puts "Такого пункта не существует!"   
    end

    puts "Создан поезд с номером: #{id_train}" 
    @trains << train
  end

  def choose_train
    @trains.each_with_index do |value, index|
      puts "#{index + 1}. Номер: #{value.id_train}    тип: #{value.type_train}"
    end
  end

  def current_train(num_train)
    current_train = @trains[num_train-1]
  end

  def create_wagon_and_add_in_train
    puts "Выберите тип вагона.\n1. Пассажирски вагон.\n2. Грузовой вагон."
    type_wagon = gets.chomp.to_i

    if type_wagon == 1
      wagon = WagonPassenger.new
    elsif type_wagon == 2
      wagon = WagonCargo.new
    end

    puts "Выберите поезд к которому прицепить вагон: "

    choose_train

    num_train = gets.chomp.to_i

    current_train(num_train-1).add_wagon(wagon)
  end

  def add_wagon_to_train
    loop do
      puts "Выберите нужный пункт:"
      puts "1. Создать вагон" 
      puts "0. Выйти."
      
      choice = gets.chomp.to_i
      
      if choice == 1
        create_wagon_and_add_in_train
      elsif choice == 0
        break
      else
        puts "Такой пункт меню отсутствует!"  
      end
    end
  end

  def delete_wagon
    puts "Выберите поезд от которого хотите отцепить вагон: "
    choose_train
    num_train = gets.chomp.to_i 
    puts "Выберите какой хотите отцепить вагон: "
    current_train(num_train - 1).show_wagons.each_with_index { |wagon, index| print " #{index + 1}: #{wagon}, тип: #{wagon.type}\n" }
    del_wagon = gets.chomp.to_i
    current_train(num_train - 1).subtract_wagon(current_train(num_train - 1).show_wagons[del_wagon-1])
  end  

  def move_train_along_the_route
    puts "Какой поезд хотите перемещать?"
    choose_train
    num_train = gets.chomp.to_i

    loop do
      puts "\n1. Посмотреть маршрутную карту.\n2. Переместить поезд на следующую станцию.\n3. Переместить поезд на предыдущую станцию.\n0. Выйти"
      gets_job = gets.chomp.to_i

      case gets_job
      when 1
        current_train(num_train).show_stations.each { |station| print "#{station.name_station} - "}  
      when 2
        current_train(num_train).move_forward
        puts "Поезд #{current_train(num_train).id_train} находится на станции: #{current_train(num_train).current_station.name_station}"
      when 3
        current_train(num_train).move_backward
        puts "Поезд #{current_train(num_train).id_train} находится на станции: #{current_train(num_train).current_station.name_station}"
      when 0
        break
      else
        puts "Такой пункт меню отсутствует!"
      end
    end 
  end


  # Все методы работы со станциями и маршрутами
  def assign_route
    puts "Выберите маршрут который хотите назначить:"
    choose_route
    gets_route = gets.chomp.to_i

    puts "Выберите поезд к которому хотите назначить маршрут: "  
    choose_train 
    num_train = gets.chomp.to_i
 
    current_train(num_train).route(@routes[gets_route - 1])       
    
    puts "Поезду '#{current_train(num_train).id_train}' назначен маршрут: 
    '#{@routes[gets_route - 1].stations.first.name_station}-#{@routes[gets_route - 1].stations.last.name_station}' "
  end

  def create_route_or_menagment_station
    loop do
      puts "Выберете: \n1. Создать маршрут." 
      puts "2. Управлять станциями." unless @routes.empty? 
      puts "0. Выйти."
      choice = gets.chomp.to_i
    
      if choice == 1
        create_route
      elsif choice == 2 
        management_route
      elsif choice == 0
        break 
      else
        puts "Такой пункт меню отсутствует!"
      end
    end
  end

  def create_route
    puts "Для создания маршрута, напишите начальную станцию:"
    starting_station = gets.chomp.to_s
    puts "Затем конечную станцию:"
    ending_station = gets.chomp.to_s
    @routes << Route.new(starting_station, ending_station)
    puts "Создан маршрут: #{@routes.last.stations.first.name_station}-#{@routes.last.stations.last.name_station}"
  end
  
  def management_route
    puts "Выберете маршрут: "

    choose_route

    choosing_route = gets.chomp.to_i
  
    puts "1. Добавить промежуточную станцию \n2. Удалить промежуточную станцию."
    choosing_station_management = gets.chomp.to_i
  
    case choosing_station_management
    when 1
      puts "Выберите станцию которую хотите добавить:"
      chooce_station
      num_station = gets.chomp.to_i
      @routes[choosing_route - 1].add_intermediate_station(@stations[num_station - 1])

    when 2
      puts "Выберете станцию которую хотите удалить: "
      count = 0
      @routes[choosing_route - 1].stations.each do |value|
        puts "#{count += 1}. #{value.name_station }" if value != @routes[choosing_route - 1].stations.first && value != @routes[choosing_route - 1].stations.last
      end
      num_station = gets.chomp.to_i

      @routes[choosing_route - 1].delete_station(@routes[choosing_route - 1].stations[num_station])
    else
      puts "Такой пункт меню отсутствует!"
    end
  end

  def choose_route
    @routes.each_with_index do |value, index|
      puts "#{index + 1}. #{value.stations.first.name_station}-#{value.stations.last.name_station}"
    end
  end

  def create_station
    puts "Напишите название станции:"
    name_station = gets.chomp.to_s
    @stations << Station.new(name_station)
    puts "Станция '#{name_station}' создана."
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
    puts "Выберите станцию для вывода списка поездов на станции:"
    gets_job = gets.chomp.to_i
    @stations[gets_job - 1].trains.each { |train| puts "На станции '#{@stations[gets_job - 1].name_station}' находится поезд: '#{train.id_train}'" }
  end
end


n = Main.new
n.start

