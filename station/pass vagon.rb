require_relative 'vagon'

class PassengerVagon < Vagon

    def initialize(num_vagon)
      super(num_vagon, "pass")
    end
  end