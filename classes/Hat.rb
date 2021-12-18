require_relative "Clothes"

class Hat < Clothes
    def initialize(name="", brand="", type="", colour="", size=0, stock=0, price=0.00)
        super(name, brand, type, colour, size, stock, price)
    end

    def display_details
    end
end