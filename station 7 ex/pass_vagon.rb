require_relative 'vagon'

class PassengerVagon < Vagon

    def initialize(num_vagon, manufacturer)
      super(num_vagon, "pass", manufacturer)
    end
  end