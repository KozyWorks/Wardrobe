require_relative "Clothes"

class Pants < Clothes
    def initialize(name, brand, size, stock, price)
        super(name, brand, size, stock, price)
    end
end