class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept(train)
    trains << train
  end

  def list_all_tr
    trains.each { |train| puts train }
  end

  def list_for_type(type)
    trains.select {|train| train.type == type}.each { |train| puts train }
  end

  def to_send(num)
    train = trains.find {|train| train.num == num}
    trains.delete(train) if train
  end
end
