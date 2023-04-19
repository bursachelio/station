class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = {}
  end

  def accept(train)
    trains[train.num] =  {'type' => train.type, 'vag' => train.vag}
  end

  def list_all_tr
    trains.each { |key, value| puts "#{key} #{value}" }
  end

  def list_for_type(type)
    trains.select {|train| traint.type == type}
  end

  def to_send(num)
    trains.delete(num)
  end
end

class Route
  attr_accessor :start_st, :finish_st, :stations

  def initialize(start_st, finish_st)
    @start_st = start_st
    @finish_st = finish_st
    @stations = [@start_st, @finish_st]
  end

  def add_st(station)
    @stations.insert(1, station)
  end

  def del_st(station)
    for i in 0..@stations.length - 1
      if @stations[i].name == station
        @stations.delete_at(i)
        break
      end
    end
  end

  def list_info
    @stations.each { |x| puts x.name }
  end
end

class Train
  attr_reader :route, :current_station_index
  attr_accessor :type, :num, :vag, :speed

  def initialize(speed, num, type, vag)
    @speed = speed
    @num = num
    @type = type
    @vag = vag
  end

  def speed_plus(speed)
    @speed = speed
  end

  def stop(speed = 0)
    @speed = speed
  end

  def speed_info
    puts speed
  end

  def change_vag_1(ch)
    if @speed == 0
      if ch > 0
        @vag += 1
      else
        @vag -= 1
      end
    end
  end

  def assign_station(route)
    @route = route
    @current_station_index = 0
    puts "Маршрут поезда назначен, поезд находится на станции #{route.stations[current_station_index].name}"
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def back_station
    route.stations[current_station_index - 1]
  end
  
  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_back_station
    @current_station_index -= 1 if back_station
  end

  def route_info
    if current_station_index > 0 && current_station_index != route.stations.length - 1
      puts "Поезд находится на станции #{route.stations[current_station_index].name}, предыдущая станция #{route.stations[current_station_index - 1].name}, следущая станция #{route.stations[current_station_index + 1].name} "
    elsif current_station_index > 0 && current_station_index == route.stations.length - 1
      puts "Предыдущая станция #{route.stations[current_station_index - 1].name}, поезд находится на последней станции #{route.stations[current_station_index].name}, просьба выйти из вагона. Уважаемые пассажиры, обращаем ваше внимание, что за нахождение в поезде, следующем в тупик, предусмотрена административная ответственность в соответствии с законодательством Российской Федерации. "
    elsif current_station_index == 0
      puts "Поезд находится на первой станции #{route.stations[current_station_index].name}, следущая станция #{route.stations[current_station_index + 1].name} "
    end
  end
end

train_1 = Train.new(0, 1, 'cargo', 6)
train_2 = Train.new(0, 2, 'pass', 10)
station_1 = Station.new('Planernaya')
station_2 = Station.new('Pushkinskaya')
station_3 = Station.new('Ryazanskyi prospekt')
route_1 = Route.new(station_1, station_3)
station_1.accept(train_1)
station_1.accept(train_2)
print station_1.list_all_tr
train_1.speed_plus(60)
train_1.stop
train_1.speed_info
route_1.add_st(station_2)
route_1.list_info
train_1.change_vag_1(1)
puts train_1.vag
train_1.assign_station(route_1)
train_1.next_station
train_1.go_next_station
train_1.route_info
train_1.next_station
train_1.go_next_station
train_1.route_info