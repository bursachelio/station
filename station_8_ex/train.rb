# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze
  include InstanceCounter

  @@trains = []

  def self.find(num)
    @@trains.find { |train| train.num == num }
  end

  include Manufacturer
  attr_reader :route, :current_station_index, :vagons
  attr_accessor :num, :speed, :type, :vagons_count, :manufacturer

  def initialize(num, type, vagons_count = 0, manufacturer)
    @num = num
    @type = type
    @speed = 0
    @vagons = []
    @vagons_count = vagons_count
    @manufacturer = manufacturer
    @@trains << self
    register_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError => e
    false
  end

  def each_vagon(&block)
    @vagons.each(&block)
  end

  private # сюда я тащу все методы которые не задействуются в других классах

  def validate!
    errors = []
    errors << 'Номер поезда не может быть пустым!' if num.empty?
    errors << 'Номер поезда не соответствует формату!' if num !~ NUMBER_FORMAT
    errors << 'Тип поезда не может быть пустым!' if type.empty?
    errors << 'Неверный тип поезда. Он может быть pass или cargo!' unless %w[pass cargo].include?(type)
    errors << 'Имя производителя не может быть пустым!' if manufacturer.empty?
    raise errors.join("\n") unless errors.empty?
  end

  def vagons_info
    @vagons.each { |v| print v.num_vagon }
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
    if current_station_index.positive? && current_station_index != route.stations.length - 1
      puts "Поезд находится на станции #{route.stations[current_station_index].name}, предыдущая станция #{route.stations[current_station_index - 1].name}, следущая станция #{route.stations[current_station_index + 1].name} "
    elsif current_station_index.positive? && current_station_index == route.stations.length - 1
      puts "Предыдущая станция #{route.stations[current_station_index - 1].name}, поезд находится на последней станции #{route.stations[current_station_index].name}, просьба выйти из вагона. Уважаемые пассажиры, обращаем ваше внимание, что за нахождение в поезде, следующем в тупик, предусмотрена административная ответственность в соответствии с законодательством Российской Федерации."
    elsif current_station_index.zero?
      puts "Поезд находится на первой станции #{route.stations[current_station_index].name}, следущая станция #{route.stations[current_station_index + 1].name}"
    end
  end

  def add_vagon(vagon)
    raise 'Невозможно добавить вагон, поезд движется!' if @speed != 0

    if @type == vagon.type_vagon
      @vagons << vagon
      @vagons_count += 1
    else
      puts 'Невозможно добавить вагон'
    end
  end

  def remove_vagon
    if @speed.zero? && !vagons.empty?
      @vagons.pop
      @vagons_count -= 1
    else
      puts 'Невозможно отцепить вагон'
    end
  end
end
