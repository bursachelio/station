require_relative 'train'

class PassengerTrain < Train

    def initialize
        super(num, "pass", 0)
    end
end