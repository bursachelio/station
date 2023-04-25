class Station
  attr_accessor :name, :trains 
# Все в модификаторе доступа public, так как эти методы используются в другиз классах
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept(train)
    trains << train
  end

  def del_train(train)
    trains.pop
  end

  private #сюда я тащу все методы которые не задействуются в других классах

  def list_all_tr
    trains.each { |train| puts train }
  end

  def list_for_type(type)
    trains.select {|train| train.type == type}.each { |train| puts train }
  end

end
