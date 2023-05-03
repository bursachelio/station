require_relative "manufacturer"

class Vagon
  
  include Manufacturer
  attr_accessor :num_vagon, :type_vagon, :manufacturer

  def initialize(num_vagon, type_vagon, manufacturer)
    @num_vagon = num_vagon
    @type_vagon = type_vagon
    @manufacturer = manufacturer
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise "Номер вагона не может быть пустым" if num_vagon.nil?
    raise "Тип поезда не может быть пустым" if type_vagon.nil?
  end
end


