class Station

    attr_accessor :name_st

    def initialize(name_st)
        @name_st = name_st
        @list_tr = {}
    end

    def accept(train)
        @list_tr[train.num] = {"type" => train.type, "vag" => train.vag} 
    end

    def list_all_tr
        @list_tr.each {|key, value| puts "#{key} #{value}"}
    end

    def list_for_type(type)
        @list_tr.each {|key, value| puts "#{key} #{value}" if type == value["type"]}
    end

    def to_send(num)
        @list_tr.delete(num)
    end

end

class Route

    attr_accessor :start_st, :finish_st

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
        @list_route.each {|x| puts x.name_st}
    end

end

class Train
    
    attr_accessor :type, :num, :vag
    attr_reader :speed

    def initialize(num, type, vag)
        @num = num
        @type = type
        @vag = vag
    end

    def start(speed = 10)
        @speed = speed
    end

    def stop(speed = 0)
        @speed = speed
    end

    def change_vag(ch)
        if ch == 1
            @vag += 1
        else
            @vag -= 1
        end
    end

    def add_route(route)
    
    end

end

train_1 = Train.new(1, "cargo", 6)
train_2 = Train.new(2, "pass", 10)
station_1 = Station.new("Planernaya")
station_2 = Station.new("Pushkinskaya")
station_3 = Station.new("Ryazanskyi prospekt")
route = Route.new(station_1, station_3)
station_1.accept(train_1)
station_1.accept(train_2)
route.add_st(station_2)

route.list_info
puts "----------------"
route.del_st("Pushkinskaya")
route.list_info