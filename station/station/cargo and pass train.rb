require_relative 'train'

class Cargotrain < Train
    def initialize
        super("train")
    end
end

class PassengerTrain < Train
    def initialize
        super("pass")
    end
end