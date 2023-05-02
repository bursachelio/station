require_relative 'train'

class Cargotrain < Train

    def initialize
        super(num, "cargo", 0)
    end
end
