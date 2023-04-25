require_relative 'route'
require_relative 'cargo vagon'
require_relative 'pass vagon'
require_relative 'cargo train'
require_relative 'pass train'

class Main

  def initialize
    @cargo_trains = []
    @passenger_trains = []
    @routes = []
    @trains = []
    @stations = []
  end

  def create_station
    puts "Введите название станции :"
    name = gets.chomp.to_s
    station = Station.new(name)
    @stations << station
    puts "Станция #{station.name} была добавлена в список станций"
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
    @stations << start_station
    puts "Введите конечную станцию маршрута:"
    finish_station = gets.chomp
    finish_station = Station.new(finish_station)
    @stations << finish_station
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
        @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
        choice = gets.chomp.to_i
        station = @stations[choice - 1]
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
    route.start_station.trains << train
    puts route.start_station.trains[train_choice - 1].num
  end

  def attach_vagon
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    if train.type == 'pass'
      puts "Введите номер вагона :"
      num_vagon = gets.chomp.to_i
      vagon = PassengerVagon.new(num_vagon)
    elsif train.type == 'cargo'
      puts "Введите номер вагона :"
      num_vagon = gets.chomp.to_i
      vagon = CargoVagon.new(num_vagon)
    end
    train.add_vagon(vagon)
    puts "Вагон прицеплен к поезду #{train.num}, список вагонов : #{train.vagons}"
  end

  def unhook_vagon
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    train.remove_vagon
    puts "Вагон отцеплен от поезда #{train.num}, список вагонов : #{train.vagons}"
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
        train.at_the_station.trains.pop
        train.go_next_station
        train.next_station.trains << train
        puts "Поезд #{train.num} #{train.route_info}"
      when 2  
        train.at_the_station.trains.pop
        train.go_back_station
        train.back_station.trains << train
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

  def list_trains_on_stations
    puts "Выберите станцию:"
    @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
    choice = gets.chomp.to_i
    station = @stations[choice - 1]
    puts "Поезда на станции #{station.name}:"
    @station.trains.each { |train| puts "#{train.num} - #{train.type}" }
  end
end

main = Main.new
=begin
  loop do
    puts "Выберите действие:"
    puts "1 - Создать станцию"
    puts "2 - Создать поезд"
    puts "3 - Создать маршрут"
    puts "4 - Управление маршрутом"
    puts "5 - Назначить маршрут поезду"
    puts "6 - Добавить вагон к поезду"
    puts "7 - Отцепить вагон от поезда"
    puts "8 - Переместить поезд по маршруту"
    puts "9 - Просмотреть список станций"
    puts "10 - Просмотреть список поездов на станции"
    puts "0 - Выход"
    choice = gets.chomp.to_i

      case choice
    when 1
      main.create_station
    when 2
      main.create_train
    when 3
      main.create_route
    when 4
      main.control_route
    when 5
      main.appoint_route
    when 6
      main.attach_vagon
    when 7
      main.unhook_vagon
    when 8
      main.moving_train
    when 9
      main.list_stations
    when 10
      main.list_trains_on_stations
    when 0
      break
    else
      puts "Неверный выбор"
    end
  end
=end