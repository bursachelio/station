require_relative 'train'

class Cargotrain < Train

    def initialize(num, type, manufacturer)
        super(num, "cargo", manufacturer)
    end
end
