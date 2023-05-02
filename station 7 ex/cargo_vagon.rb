require_relative 'vagon'

class CargoVagon < Vagon

  def initialize(num_vagon, manufacturer)
    super(num_vagon, "cargo", manufacturer)
  end
end