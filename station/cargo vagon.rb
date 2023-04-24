require_relative 'vagon'

class CargoVagon < Vagon

    def initialize(num_vagon)
      super(num_vagon, "cargo")
    end
  end