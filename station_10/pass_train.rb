require_relative 'train'
require_relative 'validation'

class PassengerTrain < Train
  include Validation

  validate :num, :presence
  validate :manufacturer, :presence

  def initialize(num, manufacturer)
    super(num, "pass", manufacturer)
    validate!
  end

  # Определение метода validations в классе PassengerTrain
  def self.validations
    @validations || []
  end
end