require_relative 'route'
require_relative 'cargo and pass vagons'
require_relative 'cargo and pass train'

class Main

  def initialize
    @cargo_trains = []
    @passenger_trains = []
    @routes = []
    @trains = []
  end

  def create_train
    puts "Введите номер поезда:"
    num = gets.chomp.to_i
    puts "Введите тип поезда:"
    type = gets.chomp
    train = Train.new(num, type, speed = 0)
    puts "Поезд с номером #{train.num} типа #{type} создан"
    if type == "pass"
      @passenger_trains << train
      @trains << train
      puts "Поезд типа pass добавлен в список пассажирских поездов"
    elsif type == "cargo" 
      @cargo_trains << train
      @trains << train
      puts "Поезд типа cargo добавлен в список грузовых поездов"
    end
  end

  def create_route
    puts "Введите начальную станцию маршрута:"
    start_station = gets.chomp
    start_station = Station.new(start_station)
    puts "Введите конечную станцию маршрута:"
    finish_station = gets.chomp
    finish_station = Station.new(finish_station)
    route = Route.new(start_station, finish_station)
    puts "Маршрут #{route.start_station.name} - #{route.finish_station.name} создан"
    @routes << route
  end

  def control_route
    puts "Выберите маршрут:"
    @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.start_station.name} - #{route.finish_station.name}" }
    choice = gets.chomp.to_i
    route = @routes[choice - 1]
    loop do
      puts "Выберите действие:"
      puts "1 - Добавить станцию"
      puts "2 - Удалить станцию"
      puts "0 - Выход"
      choice = gets.chomp.to_i
      case choice
      when 1
        puts "Введите название станции:"
        name = gets.chomp
        station = Station.new(name)
        route.add_station(station)
        puts "Станция #{station.name} добавлена в маршрут"
      when 2
        puts "Введите название станции:"
        name = gets.chomp
        route.del_station(name)
        puts "Станция #{name} удалена из маршрута"
      when 0
        break
      else
        puts "Неверный выбор"
      end
    end
  end
  
  def appoint_route
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    puts "Выберите маршрут:"
    @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.start_station.name} - #{route.finish_station.name}" }
    route_choice = gets.chomp.to_i
    route = @routes[route_choice - 1]
    train.assign_route(route)
    puts "Маршрут назначен поезду #{train.num}"
  end

  def attach_vagon
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    if train.type == 'pass'
      vagon = PassengerVagon.new
    elsif train.type == 'cargo'
      vagon = CargoVagon.new
    end
    train.add_vagon(vagon)
    puts "Вагон прицеплен к поезду #{train.num}"
  end

  def unhook_vagon
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    train.remove_vagon
    puts "Вагон отцеплен от поезда #{train.num}"
  end

  def moving_train
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    loop do
      puts "Выберите направление:"
      puts "1 - Вперед"
      puts "2 - Назад"
      puts "0 - Выход"
      direction = gets.chomp.to_i
      case direction
      when 1
        train.go_next_station
        puts "Поезд #{train.num} #{train.route_info}"
      when 2  
        train.go_back_station
        puts "Поезд #{train.num} #{train.route_info}"
      when 0
        break
      else
        puts "Неверный выбор"
      end
    end
  end

  def list_stations
    puts "Выберите маршрут:"
    @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.start_station.name} - #{route.finish_station.name}" }
    choice = gets.chomp.to_i
    route = @routes[choice - 1]
    route.list_info
  end
end


main = Main.new

  loop do
    puts "Выберите действие:"
    puts "1 - Создать поезд"
    puts "2 - Создать маршрут"
    puts "3 - Управление маршрутом"
    puts "4 - Назначить маршрут поезду"
    puts "5 - Добавить вагон к поезду"
    puts "6 - Отцепить вагон от поезда"
    puts "7 - Переместить поезд по маршруту"
    puts "8 - Просмотреть список станций"
    puts "9 - Просмотреть список поездов на станции"
    puts "0 - Выход"
    choice = gets.chomp.to_i

      case choice
    when 1
      main.create_train
    when 2
      main.create_route
    when 3
      main.control_route
    when 4
      main.appoint_route
    when 5
      main.attach_vagon
    when 6
      main.unhook_vagon
    when 7
      main.moving_train
    when 8
      main.list_stations
    when 9
      puts "Выберите станцию:"
      @stations.each_with_index { |station, index| puts "#{index + 1} - #{station}" }
      choice = gets.chomp.to_i
      station = @stations[choice - 1]
      puts "Поезда на станции #{station}:"
      station.trains.each { |train| puts "#{train.num} - #{train.type}, количество вагонов: #{train.carriages.count}" }
    when 0
      break
    end
  end
