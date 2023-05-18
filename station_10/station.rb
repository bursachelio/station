require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include Accessors
  include Validation

  attr_accessor_with_history :name

  validate :name, :presence

  def initialize(name)
    @name = name
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.validations
    @validations || []
  end

  def accept(train)
    trains << train
  end

  def del_train(train)
    raise 'На станции нет поездов' if trains.empty?

    trains.delete(train)
  end

  def self.all
    @@all_stations
  end

  def each_train(&block)
    trains.each(&block)
  end

  private

  def validate!
    super()
  end  

  def list_all_tr
    trains.each do |train|
      puts train
    end
  end

  def list_for_type(type)
    selected_trains = trains.select do |train|
      train.type == type
    end
    count = selected_trains.size
    puts "На станции #{name} #{count} поездов типа #{type}:"
    selected_trains.each do |train|
      puts train
    end
  end
end
