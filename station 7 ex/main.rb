require_relative 'route'
require_relative 'cargo_vagon'
require_relative 'pass_vagon'
require_relative 'cargo_train'
require_relative 'pass_train'

class Main

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

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
      raise "Название станции не может быть пустым!" if name.empty?
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      return
    end
    station = Station.new(name)
    @stations << station
    puts "Станция #{station.name} была добавлена в список станций"
  end

  def create_train

    begin
      puts "Введите номер поезда:"
      num = gets.chomp
      raise "Номер поезда не может быть пустым!" if num.empty?
      raise "Номер поезда не соответствует формату!" if num !~ NUMBER_FORMAT
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      return
    end
  
    begin
      puts "Введите тип поезда:"
      type = gets.chomp
      raise "Неверный тип поезда. Он может быть pass или cargo!" unless type == "pass" || type == "cargo"
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      return
    end
  
    begin
      puts "Введите производителя поезда:"
      manufacturer = gets.chomp
      raise "Имя производителя не может быть пустым!" if manufacturer.empty?
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      return
    end
  
    train = Train.new(num, type, manufacturer)
    puts "Поезд с номером #{train.num} типа #{type} от производителя #{manufacturer} создан"
  
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
    begin
      puts "Введите начальную станцию маршрута:"
      start_station = gets.chomp
      raise "Имя станции не может быть пустым" if start_station.empty?
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      return
    end
    start_station = Station.new(start_station)
    @stations << start_station
      
    begin
      puts "Введите конечную станцию маршрута:"
      finish_station = gets.chomp
      raise "Имя станции не может быть пустым" if finish_station.empty?
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
      return
    end
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
    route.start_station.accept(train)
  end

  def attach_vagon
    puts "Выберите поезд: "
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.num}" }
    train_choice = gets.chomp.to_i
    train = @trains[train_choice - 1]
    
    begin
      puts "Введите тип вагона: "
      type_vagon = gets.chomp
      raise "Тип вагона не может быть пустым!" if type_vagon.empty?
    rescue StandardError => e
      puts "Ошибка: #{e.message}" 
        return
    end
      
    if train.type == 'pass'
      begin
        puts "Введите номер вагона :"
        num_vagon = gets.chomp
        raise "Номер вагона не может быть пустым!" if num_vagon.empty?
      rescue StandardError => e
        puts "Ошибка: #{e.message}" 
        return
      end

      begin
        puts "Введите производителя вагона :"
        manufacturer = gets.chomp.to_s
        raise "Имя производителя вагона не может быть пустым!" if num_vagon.empty?
      rescue StandardError => e
        puts "Ошибка: #{e.message}" 
        return
      end

    elsif train.type == 'cargo'
      begin
        puts "Введите номер вагона :"
        num_vagon = gets.chomp
        raise "Номер вагона не может быть пустым!" if num_vagon.empty?
      rescue StandardError => e
        puts "Ошибка: #{e.message}" 
        return
      end

      begin
        puts "Введите производителя вагона :"
        manufacturer = gets.chomp.to_s
        raise "Имя производителя вагона не может быть пустым!" if num_vagon.empty?
      rescue StandardError => e
        puts "Ошибка: #{e.message}" 
        return
      end
      vagon = CargoVagon.new(num_vagon, manufacturer)
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
end