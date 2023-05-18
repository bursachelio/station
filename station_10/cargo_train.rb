require_relative 'train'
require_relative 'validation'

class CargoTrain < Train
  include Validation

  validate :num, :presence
  validate :manufacturer, :presence

  def initialize(num, manufacturer)
    super(num, "cargo", manufacturer)
    validate!
  end

  # Определение метода validations в классе CargoTrain
  def self.validations
    @validations || []
  end
end
