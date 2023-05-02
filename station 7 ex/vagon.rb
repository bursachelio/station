require_relative "manufacturer"

class Vagon
  
  include Manufacturer
  attr_accessor :num_vagon, :type_vagon, :manufacturer

  def initialize(num_vagon, type_vagon, manufacturer)
    @num_vagon = num_vagon
    @type_vagon = type_vagon
    @manufacturer = manufacturer
  end
  
end


