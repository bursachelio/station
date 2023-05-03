module Manufacturer
    attr_accessor :manufacturer
    def initialize(manufacturer)
        @manufacturer = manufacturer
        validate!
    end

    def valid?
        true
    rescue
        false
    end

    private

    def validate!
        raise "Производитель поезда не может быть пустым" if manufacturer.nil?
    end
end