# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include InstanceCounter

  @@trains = []

  def self.find(num)
    @@trains.find do |train|
      train.num == num
    end
  end

  include Manufacturer
  attr_reader :route, :current_station_index, :vagons
  attr_accessor :num, :speed, :type, :vagons_count, :manufacturer

  def initialize(num, type, manufacturer)
    @num = num
    @type = type
    @speed = 0
    @vagons = []
    @vagons_count = 0
    @manufacturer = manufacturer
    @@trains << self
    register_instance
  end

  def each_vagon(&block)
    @vagons.each(&block)
  end

  private

  def vagons_info
    @vagons.each do |v|
      print v.num_vagon
    end
  end

  public

  def assign_route(route)
    @route = route
    @current_station_index = 0
    puts "Поезд на станции #{route.stations[current_station_index].name}"
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
    return unless next_station

    @current_station_index += 1
  end

  def go_back_station
    return unless back_station

    @current_station_index -= 1
  end

  def route_info
    case current_station_index
    when 0
      first_station_info
    when route.stations.length - 1
      last_station_info
    else
      intermediate_station_info
    end
  end

  def intermediate_station_info
    puts "Поезд на станции #{at_the_station.name}, " \
         "предыдущая станция #{back_station.name}, " \
         "следующая станция #{next_station.name}"
  end

  def last_station_info
    puts "Предыдущая станция #{back_station.name}," \
         " поезд на последней станции #{at_the_station.name}"
  end

  def first_station_info
    puts "Поезд на первой станции #{at_the_station.name}," \
         " следущая станция #{next_station.name}"
  end

  def add_vagon(vagon)
    return puts 'Невозможно добавить вагон, поезд движется!' if @speed != 0
    return puts 'Невозможно добавить вагон' if @type != vagon.type_vagon

    @vagons << vagon
    @vagons_count += 1
  end

  def remove_vagon
    return puts 'Невозможно отцепить вагон' if @speed.nonzero? || @vagons.empty?

    @vagons.pop
    @vagons_count -= 1
  end
end
