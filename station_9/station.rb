# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter
  @@all_stations = []
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
    retry
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
    return unless name.empty?

    raise 'Название станции не может быть пустым!'
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
