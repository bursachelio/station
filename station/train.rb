class Train
  attr_reader :route, :current_station_index, :vagons
  attr_accessor :num, :speed, :type

  def initialize(num, type, speed = 0)
    @num = num
    @type = type
    @speed = speed
    @vagons = []
  end

  def speed_plus(speed)
    @speed = speed
  end

  def stop(speed = 0)
    @speed = speed
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    puts "Маршрут поезда назначен, поезд находится на станции #{route.stations[current_station_index]}"
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
      puts "Поезд находится на станции #{route.stations[current_station_index]}, предыдущая станция #{route.stations[current_station_index - 1]}, следущая станция #{route.stations[current_station_index + 1]} "
    elsif current_station_index > 0 && current_station_index == route.stations.length - 1
      puts "Предыдущая станция #{route.stations[current_station_index - 1]}, поезд находится на последней станции #{route.stations[current_station_index]}, просьба выйти из вагона. Уважаемые пассажиры, обращаем ваше внимание, что за нахождение в поезде, следующем в тупик, предусмотрена административная ответственность в соответствии с законодательством Российской Федерации."
    elsif current_station_index == 0
      puts "Поезд находится на первой станции #{route.stations[current_station_index]}, следущая станция #{route.stations[current_station_index + 1]}"
    end
  end

  def add_vagon(vagon)
    if @speed == 0 && @type == vagon.type_vagon
      @vagons << vagon
    else
      puts "Невозможно добавить вагон"
    end
  end
  
  def remove_vagon
    if @speed == 0 && !vagons.empty?
      @vagons.pop
    else
      puts "Невозможно отцепить вагон"
    end
  end
end