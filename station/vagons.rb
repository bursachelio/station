class Vagon
  attr_reader :type_vagon

  def initialize(type_vagon)
    @type_vagon = type_vagon
  end
end

class PassengerVagon < Vagon
  attr_reader :seats

  def initialize
    super("pass")
  end
end

class CargoVagon < Vagon
  attr_reader :capacity

  def initialize
    super("cargo")
  end
end
