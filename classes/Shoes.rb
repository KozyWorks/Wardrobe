require_relative "Clothes"

class Shoes < Clothes
    def initialize(name, brand, color, size, stock, price, type)
        super(name, brand, color, size, stock, price)

        @type = type
    end
end