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
    true
  rescue
    false
  end

  private

  def validate!
    errors = []
    errors << "Номер вагона не может быть пустым!" if num_vagon.empty?
    errors << "Неверный тип вагона. Он может быть pass или cargo!" unless ["pass", "cargo"].include?(type_vagon)
    errors << "Имя производителя вагона не может быть пустым!" if manufacturer.empty?
    raise errors.join("\n") unless errors.empty?
  end

end


