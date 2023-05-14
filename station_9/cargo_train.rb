# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(num, _type, manufacturer)
    super(num, 'cargo', manufacturer)
  end
end
