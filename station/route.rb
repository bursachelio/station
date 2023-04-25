require_relative 'station'
# Все в модификаторе доступа public, так как эти методы используются в другиз классах
class Route
    attr_accessor :start_station, :finish_station, :stations
  
    def initialize(start_station, finish_station)
      @start_station = start_station
      @finish_station = finish_station
      @stations = [@start_station, @finish_station]
    end
  
    def add_station(station)
      @stations.insert(1, station)
    end
  
    def del_station(station)
      for i in 0..@stations.length - 1
        if @stations[i] == station
          @stations.delete_at(i)
          break
        end
      end
    end
  
    def list_info
      puts "Список станций в маршруте :"
      @stations.each { |x| print "#{x.name}, "}
      puts " "
    end
end
