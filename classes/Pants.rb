require_relative "Clothes"

class Pants < Clothes
    def initialize(name, brand, type, color, size, stock, price)
        super(name, brand, type, color, size, stock, price)
    end
end