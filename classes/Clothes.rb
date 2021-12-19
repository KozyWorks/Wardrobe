require "colorize"

require_relative "Goods"

class Clothes < Goods
    def initialize(name="", brand="", type="", colour="", size=0, stock=0, price=0.00)
        super(name, brand, type, stock, price)

        @colour = colour
        @size = size
    end

    def display_details
        return "Name:".colorize(:yellow) + " #{@name} / " +
        "Brand:".colorize(:yellow) + " #{@brand}" +
        "\nType:".colorize(:yellow) + " #{@type}" +
        "\nColour:".colorize(:yellow) + " #{@colour}" +
        "\nSize:".colorize(:yellow) + " #{@size}" +
        "\nStock:".colorize(:yellow) + " #{@stock} / " +
        "Price:".colorize(:yellow) + " $#{@price}"
    end
end