require_relative "Clothes.rb"

class Pants < Clothes
    def initialize(name="", brand="", type="", colour="", size=0, stock=0, price=0.00)
        super(name, brand, type, colour, size, stock, price)
    end
end