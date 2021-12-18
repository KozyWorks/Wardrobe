require_relative "Clothes"

class Shoes < Clothes
    def initialize(name="", brand="", type="", colour="", size=0, stock=0, price=0.00)
        super(name, brand, type, colour, size, stock, price)
    end

    def display_details
        return "Name: #{@name}\nBrand: #{@brand}\nType: #{@type}\nColour: #{@colour}\nSize: #{@size}\n(Stock: #{@stock})\nPrice: $#{@price}"
    end
end