require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'route'
require_relative 'stations'
require "byebug"


class Main
  
  def initialize
    stations = {}
    trains = {} 
    routes = {}
    wagons = {}
  end
  
  def menu
    puts "Выберите действие:"
    #puts "1. - Создать станцию"
    puts "1. - Создать поезд"
    puts "2. - Создать маршруты и управлять станциями"
    puts "3. - Назначить маршрут поезду"
    puts "4. - Добавить вагоны к поезду"
    puts "5. - Отцепить вагоны от поезда"
    puts "6. - Переместить поезд по маршруту"
    puts "7. - Просматреть список станций и список поездов на станции"
    puts "0. - Выйти"
  end

end






loop do
  menu
  choice = gets.chomp.to_i

  case choice

  when 1
    puts "Выберите тип поезда: \n1. Пассажирский поезд. \n2. Грузовой поезд"
    choice_type = gets.chomp.to_i
    case choice_type
    when 1
      puts "Впишите номер поезда:" 
      id_train = gets.chomp
      train = PassengerTrain.new(id_train) 
      trains[id_train] = train
      puts "Создана поезд с номером: #{id_train}"
    when 2
      puts "Впишите номер поезда:" 
      id_train = gets.chomp
      train = CargoTrain.new(id_train) 
      trains[id_train] = train
      puts "Создана поезд с номером: #{id_train}"  
    end

  
  when 2
    loop do
       
      puts "Выберете: \n1. Создать маршрут." 
      puts "2. Управлять станциями." unless stations.empty? 
      puts "0. Выйти."
      choice_3 = gets.chomp.to_i

      case choice_3
      when 1
        puts "Для создания маршрута, напишите начальную станцию:"
        starting_station = gets.chomp.to_s
        puts "Затем конечную станцию:"
        ending_station = gets.chomp.to_s
        route = Route.new(starting_station, ending_station)
        stations["#{starting_station}-#{ending_station}"] = route
        puts "Создан маршрут: #{starting_station}-#{ending_station}"
      
      when 2  
        puts "Выберете маршрут: "
        count = 1
        stations.each do |key, values|
          puts "#{count}. #{key}"
          count += 1
        end
        choosing_route = gets.chomp.to_i

        @route = [] 

        puts "1. Добавить промежуточную станцию \n2. Удалить промежуточную станцию. \n3. Выйти"
        choosing_station_management = gets.chomp.to_i

        case choosing_station_management
        when 1
          puts "Дайте название станции:"
          name_station = gets.chomp.to_s
          stations.each_with_index { |(key, value), index| @route = value if index == choosing_route - 1}
          @route.add_intermediate_station(name_station)
          puts "#{@route.show_stations}"
        
        when 2
          puts "Выберете станцию которую хотите удалить: "
          stations.each_with_index { |(key, value), index| @route = value if index == choosing_route - 1}
          count = 1
          @route.show_stations.each do |value|
            puts "#{count}. #{value[0].name_station}"
            count += 1
          end
          choosing_route = gets.chomp.to_i

          @route.delete_station(@route.stations[choosing_route-1])
          puts "#{@route.show_stations}"
        end
      when 0
        break  
      end
    end

  when 4
    puts "Выберите нужный пункт:"
    puts "1. Создать вагон" 
    puts "2. Выбрать вагон из списка." unless wagons.empty? 
    puts "0. Выйти."
    
    choice_4 = gets.chomp.to_i
    
    if choice_4 == 1
      puts "Выберите тип вагона.\n1. Пассажирски вагон.\n2. Грузовой вагон."
      type_wagon= gets.chomp.to_i

      puts "напишите id вагона"
      id_wagon = gets.chomp.to_i
    
      puts "Выберите поезд к которому прицепить вагон: "
      count = 0
      trains.each_with_index { |(key, value), index| puts "#{count+=1}: #{key}" }
      id_train = gets.chomp.to_i
    end

    

    #trains[add_wagon
  #when 5    

  when 0
    break
  else
    puts "Неверный выбор. Попробуйте снова."
    
  end

end