require_relative 'vagons'

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