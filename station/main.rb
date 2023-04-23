require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'vagons'

trains = []
routes = []
stations = []

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
    puts "Введите название станции:"
    name = gets.chomp
    station = Station.new(name)
    puts "Станция #{station.name} создана"
    stations << station
  when 2
    puts "Введите номер поезда:"
    num = gets.chomp.to_i
    puts "Введите тип поезда:"
    type = gets.chomp
    train = Train.new(num, type, speed = 0)
    puts "Поезд с номером #{train.num} типа #{type} создан"
    trains << train
  when 3
    puts "Введите начальную станцию маршрута:"
    start_station = gets.chomp
    puts "Введите конечную станцию маршрута:"
    finish_station = gets.chomp
    route = Route.new(start_station, finish_station)
    puts "Маршрут #{route.start_station} - #{route.finish_station} создан"
    routes << route
  when 4
    puts "Выберите маршрут:"
    routes.each_with_index { |route, index| puts "#{index + 1} - #{route.start_station} - #{route.finish_station}" }
    choice = gets.chomp.to_i
    route = routes[choice - 1]
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
  when 5
    puts "Выберите поезд:"
    trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = trains[train_choice - 1]

    puts "Выберите маршрут:"
    routes.each_with_index { |route, index| puts "#{index + 1} - #{route.start_station} - #{route.finish_station}" }
    route_choice = gets.chomp.to_i
    route = routes[route_choice - 1]

    train.assign_route(route)
    puts "Маршрут назначен поезду #{train.num}"

  when 6
    puts "Выберите поезд:"
    trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = trains[train_choice - 1]

    if train.type == 'pass'
      vagon = PassengerVagon.new(seats)
    elsif train.type == 'cargo'
      vagon = CargoVagon.new(capacity)
    end

    train.add_vagon(vagon)
    puts "Вагон добавлен к поезду #{train.num}"

  when 7
    puts "Выберите поезд:"
    trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = trains[train_choice - 1]

    train.remove_vagon
    puts "Вагон отцеплен от поезда #{train.num}"

  when 8
    puts "Выберите поезд:"
    trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = trains[train_choice - 1]

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

  when 9
    puts "Список станций:"
    route.list_info

  when 10
    puts "Выберите станцию:"
    stations.each_with_index { |station, index| puts "#{index + 1} - #{station}" }
    choice = gets.chomp.to_i
    station = stations[choice - 1]
    puts "Поезда на станции #{station}:"
    station.trains.each { |train| puts "#{train.num} - #{train.type}, количество вагонов: #{train.carriages.count}" }
  end
  
end