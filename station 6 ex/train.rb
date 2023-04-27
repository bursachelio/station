require_relative "manufacturer.rb"

class Train

  include InstanceCounter

  @@trains = []

  def self.find(num)
    @@trains.find { |train| train.num == num }
  end

  include Manufacturer
  attr_reader :route, :current_station_index, :vagons
  attr_accessor :num, :speed, :type, :manufacturer

  def initialize(num, type, speed = 0, manufacturer)
    @num = num
    @type = type
    @speed = speed
    @vagons = []
    @manufacturer = manufacturer
    @@trains << self
  end

  private #сюда я тащу все методы которые не задействуются в других классах

  def vagons_info
    @vagons.each {|v| print v.num_vagon}
  end
# Все в модификаторе доступа public, так как эти методы используются в другиз классах
  public

  def assign_route(route)
    @route = route
    @current_station_index = 0
    puts "Маршрут поезда назначен, поезд находится на станции #{route.stations[current_station_index].name}"
  end

  def at_the_station
    route.stations[current_station_index]
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
      puts "Предыдущая станция #{route.stations[current_station_index - 1].name}, поезд находится на последней станции #{route.stations[current_station_index].name}, просьба выйти из вагона. Уважаемые пассажиры, обращаем ваше внимание, что за нахождение в поезде, следующем в тупик, предусмотрена административная ответственность в соответствии с законодательством Российской Федерации."
    elsif current_station_index == 0
      puts "Поезд находится на первой станции #{route.stations[current_station_index].name}, следущая станция #{route.stations[current_station_index + 1].name}"
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
