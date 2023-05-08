require_relative 'instance_counter'

class Station
  
  include InstanceCounter
  @@all_stations = []
  attr_accessor :name, :trains 
# Все в модификаторе доступа public, так как эти методы используются в другиз классах
  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    validate!
  end

  def valid?
    validate!
    true
  rescue => e
    false
  end

  def accept(train)
    trains << train
  end

  def del_train(train)
    raise "На станции нет поездов" if trains.empty?
    trains.delete(train)
  end

  def self.all
    @@all_stations
  end

  def each_train(&block)
    trains.each(&block)
  end

  private #сюда я тащу все методы которые не задействуются в других классах

  def validate!
    raise "Название станции не может быть пустым!" if name.empty?
  end

  def list_all_tr
    trains.each { |train| puts train }
  end

  def list_for_type(type)
    selected_trains = trains.select { |train| train.type == type }
    count = selected_trains.size
    puts "На станции #{name} #{count} поездов типа #{type}:"
    selected_trains.each { |train| puts train }
  end
end