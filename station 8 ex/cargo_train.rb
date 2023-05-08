require_relative 'train'

class CargoTrain < Train

    def initialize(num, type, manufacturer)
        super(num, "cargo", manufacturer)
    end
end
