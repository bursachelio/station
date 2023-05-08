require_relative 'route'
require_relative 'cargo_vagon'
require_relative 'pass_vagon'
require_relative 'cargo_train'
require_relative 'pass_train'

class Main

  def initialize
    @cargo_trains = []
    @passenger_trains = []
    @routes = []
    @trains = []
    @stations = []
  end

  def create_station
    begin
      puts "Введите название станции :"
      name = gets.chomp
      station = Station.new(name)
      @stations << station
      puts "Станция #{station.name} была добавлена в список станций"
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      retry
    end
  end

  def create_train
    begin
      puts "Введите номер поезда:"
      num = gets.chomp
      puts "Введите тип поезда:"
      type = gets.chomp
      puts "Введите производителя поезда:"
      manufacturer = gets.chomp
      if type == "pass"
        train = PassengerTrain.new(num, type, manufacturer)
      elsif type == "cargo"
        train = CargoTrain.new(num, type, manufacturer)
      end
      @trains << train
      puts "Поезд #{train.num} типа #{train.type} с количеством вагонов #{train.vagons_count} от производителя #{train.manufacturer} создан"
    rescue => e
      puts "Ошибка: #{e.message}" 
      retry
    end
  end

  def create_route
    begin
      puts "Введите начальную станцию маршрута:"
      start_station = gets.chomp
      start_station = Station.new(start_station)
      @stations << start_station
      puts "Станция #{start_station.name} была добавлена в список станций"
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      retry
    end
    
    begin
      puts "Введите конечную станцию маршрута:"
      finish_station = gets.chomp
      finish_station = Station.new(finish_station)
      @stations << finish_station
      puts "Станция #{finish_station.name} была добавлена в список станций"
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      retry
    end
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
    route.start_station.accept(train)
  end

  def attach_vagon
    begin
      puts "Выберите поезд: "
      @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
      train_choice = gets.chomp.to_i
      train = @trains[train_choice - 1]
      puts "Введите номер вагона :"
      num_vagon = gets.chomp
      puts "Введите тип вагона: "
      type_vagon = gets.chomp
      puts "Введите производителя вагона :"
      manufacturer = gets.chomp
      if type_vagon == "pass"
        puts "Введите количество мест в вагоне :"
        seats = gets.chomp.to_i
        vagon = PassengerVagon.new(num_vagon, type_vagon, manufacturer, seats)
      elsif type_vagon == "cargo"
        puts "Введите вместимость вагона"
        volume = gets.chomp.to_i
        vagon = CargoVagon.new(num_vagon, type_vagon, manufacturer, volume)
      end
      train.add_vagon(vagon)
      puts "Вагон прицеплен к поезду #{train.num}, список вагонов : #{train.vagons}"
   rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      retry
    end 
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
        train.go_next_station
        train.at_the_station.accept(train)
        train.back_station.del_train(train)
        puts "Поезд #{train.num} #{train.route_info}"
      when 2  
        train.go_back_station
        train.at_the_station.accept(train)
        train.next_station.del_train(train)
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
    station.trains.each { |train| puts "#{train.num} - #{train.type}" }
  end

  def each_stations
    @stations.each do |station|
      puts "Список поездов на станции #{station.name}:"
      station.trains.each do |train|
        puts "- Номер поезда: #{train.num}, тип: #{train.type}, кол-во вагонов: #{train.vagons_count}"
        train.vagons.each do |vagon| 
          if vagon.is_a?(PassengerVagon)
            puts "-- Номер вагона: #{vagon.num_vagon}, тип: #{vagon.type_vagon}, кол-во свободных мест: #{vagon.free_seats}, кол-во занятых мест: #{vagon.occupied_seats}"
          elsif vagon.is_a?(CargoVagon)
            puts "-- Номер вагона: #{vagon.num_vagon}, тип: #{vagon.type_vagon}, свободный объем: #{vagon.free_volume}, занятый объем: #{vagon.occupied_volume}"
          end
        end
      end
    end
  end

  def refueling_the_vagon
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    puts "Выберите вагон:"
    train.vagons.each_with_index { |vagon, index| puts "#{index + 1} - #{vagon.num_vagon}" }
    vagon_choice = gets.chomp.to_i
    vagon = train.vagons[vagon_choice - 1]
    if vagon.type_vagon == "pass"
      vagon.occupy_seat
    elsif vagon.type_vagon == "cargo"
      puts "Введите количество объема которое хотите занять: "
      amount = gets.chomp.to_i
      vagon.load_cargo(amount)
    end
  end
end