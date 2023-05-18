# frozen_string_literal: true

require_relative 'station'

class Route
  include InstanceCounter
  attr_accessor :start_station, :finish_station, :stations

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = [
      @start_station, @finish_station
    ]
  end

  def add_station(station)
    @stations.insert(
      1, station
    )
  end

  def del_station(station)
    (0..@stations.length - 1).each do |i|
      if @stations[i] == station
        @stations.delete_at(i)
        break
      end
    end
  end

  def list_info
    puts 'Список станций в маршруте :'
    @stations.each do |x|
      print "#{x.name}, "
    end
    puts ' '
  end
end
