# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(num, _type, manufacturer)
    super(num, 'pass', manufacturer)
  end
end
