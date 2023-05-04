require_relative 'train'

class PassengerTrain < Train

    def initialize(num, type, manufacturer)
        super(num, "pass", manufacturer)
    end
end