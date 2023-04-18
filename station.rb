  class Station
    attr_accessor :name_st
  
    def initialize(name_st)
      @name_st = name_st
      @list_tr = {}
    end
  
    def accept(train)
      @list_tr[train.num] = { 'type' => train.type, 'vag' => train.vag }
    end
  
    def list_all_tr
      @list_tr.each { |key, value| puts "#{key} #{value}" }
    end
  
    def list_for_type(type)
      @list_tr.each { |key, value| puts "#{key} #{value}" if type == value['type'] }
    end
  
    def to_send(num)
      @list_tr.delete(num)
    end
  end
  
  class Route
    attr_accessor :start_st, :finish_st, :list_route
  
    def initialize(start_st, finish_st)
      @start_st = start_st
      @finish_st = finish_st
      @list_route = [@start_st, @finish_st]
    end
  
    def add_st(station)
      @list_route.insert(1, station)
    end
  
    def del_st(station)
      for i in 0..@list_route.length - 1
        if @list_route[i].name_st == station
          @list_route.delete_at(i)
          break
        end
      end
    end
  
    def list_info
      @list_route.each { |x| puts x.name_st }
    end
  end
  
  class Train
    attr_accessor :type, :num, :vag, :speed
  
    def initialize(speed, num, type, vag)
      @speed = speed
      @num = num
      @type = type
      @vag = vag
    end
  
    def sped_plus(speed)
      @speed = speed
    end
  
    def stop(speed = 0)
      @speed = speed
    end
  
    def speed_info
      puts @speed
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
  
    def vag_info
      puts @vag
    end
  
    def add_route(route)
      @route = route
      @index_cur_st = 0
      puts "Маршрут поезда назначен, поезд находится на станции #{route.list_route[@index_cur_st].name_st}"
      @lenght_route = @route.list_route.length - 1
    end

    def change_st_1(ch_st)
      if ch_st > 0
        if @index_cur_st != @lenght_route
          @index_cur_st += 1
        else
          puts "Поезд находится на конечной станции"
        end
      else 
        if @index_cur_st != 0
          @index_cur_st -= 1
        else
          puts "Поезд находится на первой станции"
        end
      end
    end

    def route_info
      if @index_cur_st > 0 && @index_cur_st != @lenght_route
        puts "Поезд находится на станции #{@route.list_route[@index_cur_st].name_st}, предыдущая станция #{@route.list_route[@index_cur_st - 1].name_st}, следущая станция #{@route.list_route[@index_cur_st + 1].name_st} "
      elsif @index_cur_st > 0 && @index_cur_st == @lenght_route
        puts "Предыдущая станция #{@route.list_route[@index_cur_st - 1].name_st}, поезд находится на последней станции #{@route.list_route[@index_cur_st].name_st}, просьба выйти из вагона. Уважаемые пассажиры, обращаем ваше внимание, что за нахождение в поезде, следующем в тупик, предусмотрена административная ответственность в соответствии с законодательством Российской Федерации. "
      elsif @index_cur_st == 0
        puts "Поезд находится на первой станции #{@route.list_route[@index_cur_st].name_st}, следущая станция #{@route.list_route[@index_cur_st + 1].name_st} "
      end
    end
  end
  
train_1 = Train.new(0, 1, 'cargo', 6)
train_2 = Train.new(0, 2, 'pass', 10)
station_1 = Station.new('Planernaya')
station_2 = Station.new('Pushkinskaya')
station_3 = Station.new('Ryazanskyi prospekt')
route = Route.new(station_1, station_3)
station_1.accept(train_1)
station_1.accept(train_2)
route.add_st(station_2)
route.list_info
train_1.speed_info
train_1.change_vag_1(2)
train_1.vag_info
train_1.add_route(route)
train_1.change_st_1(2)
train_1.route_info
train_1.change_st_1(2)
train_1.route_info

  # route.list_info
  # puts "----------------"
  # route.del_st("Pushkinskaya")
  # route.list_info
  