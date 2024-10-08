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
  attr_reader :trains, :routes, :stations

  
  def initialize
    @stations = [Station.new("Рязань"), Station.new("Тверь"), Station.new("Омск")]
    @trains = [PassengerTrain.new("222"), PassengerTrain.new("888"), PassengerTrain.new("555"), CargoTrain.new("carg111")]
    @routes = [Route.new("Сочи", "Москва"), Route.new("Саранск", "Воронеж"), Route.new("Орел", "Коломна")]
  end

  def start
    loop do
      menu
      choice = gets.chomp.to_i

      case choice
      when 1
        create_station  
      when 2
        create_train
      when 3
        loop do
          puts "Выберете: \n1. Создать маршрут." 
          puts "2. Управлять станциями." unless @routes.empty? 
          puts "0. Выйти."
          choice_2 = gets.chomp.to_i
        
          if choice_2 == 1
            create_route
          elsif choice_2 == 2 
            management_route
          elsif choice_2 == 0
            break 
          else
            puts "Такой пункт меню отсутствует!"
          end
        end
      when 4
        puts "Выберите маршрут который хотите назначить:"
        chooce_route
        gets_route = gets.chomp.to_i

        puts "Выберите поезд к которому хотите назначить маршрут: "  
        chooce_train 
        gets_train = gets.chomp.to_i
     
        @trains[gets_train - 1].route(@routes[gets_route - 1])       
        
        puts "Поезду '#{@trains[gets_train - 1].id_train}' назначен маршрут: '#{@routes[gets_route - 1].stations.first.name_station}-#{@routes[gets_route - 1].stations.last.name_station}' "
      when 5
        loop do
          puts "Выберите нужный пункт:"
          puts "1. Создать вагон" 
          puts "0. Выйти."
          
          choice_4 = gets.chomp.to_i
          
          if choice_4 == 1
            create_wagon_and_add_in_train
          elsif choice_4 == 0
            break
          else
            puts "Такой пункт меню отсутствует!"  
          end
        end
      when 6
        delete_wagon
      when 8 
        puts "Какой поезд хотите перемещать?"
        chooce_train
        gets_train = gets.chomp.to_i
        loop do
          puts "\n1. Посмотреть маршрутную карту.\n2. Переместить поезд на следующую станцию.\n3. Переместить поезд на предыдущую станцию.\n0. Выйти"
          gets_job = gets.chomp.to_i

          case gets_job
          when 1
            @trains[gets_train - 1].show_stations.each { |station| print "#{station.name_station} - "}  
          when 2
            @trains[gets_train - 1].move_forward
            puts "Поезд #{@trains[gets_train - 1].id_train} находится на станции: #{@trains[gets_train - 1].current_station.name_station}"
          when 3
            @trains[gets_train - 1].move_backward
            puts "Поезд #{@trains[gets_train - 1].id_train} находится на станции: #{@trains[gets_train - 1].current_station.name_station}"
          when 0
            break
          else
            puts "Такой пункт меню отсутствует!"
          end
        end 
      when 9  
        chooce_station
        puts "Выберите станцию для вывода списка поездов на станции:"
        gets_job = gets.chomp.to_i
        @stations[gets_job - 1].trains.each { |train| print "#{train.id_train} - "}
      when 0
        break  
      else
        puts "Такой пункт меню отсутствует!"  
      end
    end
  end

  def menu
    puts ""
    puts "Выберите действие:"
    puts "1. - Создать станцию"
    puts "2. - Создать поезд"
    puts "3. - Создать маршруты / управлять станциями"
    puts "4. - Назначить маршрут поезду"
    puts "5. - Добавить вагоны к поезду"
    puts "6. - Отцепить вагоны от поезда"
    puts "8. - Переместить поезд по маршруту"
    puts "9. - Просматреть список станций и список поездов на станции"
    puts "0. - Выйти"
  end

  def create_station
    puts "Напишите название станции:"
    name_station = gets.chomp.to_s
    @stations << Station.new(name_station)
    puts "Станция '#{name_station}' создана."
  end

  def create_train
    puts "Выберите тип поезда: \n1. Пассажирский поезд. \n2. Грузовой поезд"
    chooce_type = gets.chomp.to_i
    puts "Впишите номер поезда:" 
    id_train = gets.chomp.to_s

    case chooce_type
    when 1
      train = PassengerTrain.new(id_train) 
    when 2
      train = CargoTrain.new(id_train) 
    else
      puts "Такого пункта не существует!"   
    end

    puts "Создана поезд с номером: #{id_train}" 
    @trains << train
  end


  def create_route
    puts "Для создания маршрута, напишите начальную станцию:"
    starting_station = gets.chomp.to_s
    puts "Затем конечную станцию:"
    ending_station = gets.chomp.to_s
    @routes << Route.new(starting_station, ending_station)
    puts "Создан маршрут: #{@routes.last.stations.first.name_station}-#{@routes.last.stations.last.name_station}"
  end
  
  def chooce_route
    count = 1
    @routes.each do |value|
      puts "#{count}. #{value.stations.first.name_station}-#{value.stations.last.name_station}"
      count += 1
    end
  end

  def chooce_station
    count = 1
    @stations.each do |value|
      puts "#{count}. #{value.name_station}"
      count += 1
    end
  end

  def chooce_train
    count = 1
    @trains.each do |value|
      puts "#{count}. Номер: #{value.id_train}    тип: #{value.type_train}"
      count += 1
    end
  end

  def management_route
    puts "Выберете маршрут: "

    chooce_route

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
      @routes[choosing_route - 1].delete_station(@stations[num_station - 1])
    else
      puts "Такой пункт меню отсутствует!"
    end
  end

  def create_wagon_and_add_in_train
    puts "Выберите тип вагона.\n1. Пассажирски вагон.\n2. Грузовой вагон."
    type_wagon = gets.chomp.to_i

    puts "Hапишите id вагона"
    id_wagon = gets.chomp.to_i

    if type_wagon == 1
      wagon = WagonPassenger.new(id_wagon)
    elsif type_wagon == 2
      wagon = WagonCargo.new(id_wagon)
    end

    puts "Выберите поезд к которому прицепить вагон: "

    chooce_train

    num_train = gets.chomp.to_i

    @trains[num_train-1].add_wagon(wagon)
  end

  def delete_wagon
    puts "Выберите поезд от которого хотите отцепить вагон: "

    chooce_train
    
    num_train = gets.chomp.to_i
  
    puts "Выберите какой хотите отцепить вагон: "
    c=0
    @trains[num_train-1].show_wagons.each { |wagon| puts "#{c+=1}: #{wagon.id_wagon}" }
    del_wagon = gets.chomp.to_i
    @trains[num_train-1].subtract_wagon(@trains[num_train-1].show_wagons[del_wagon-1])
  end  
end


n = Main.new
n.start

