require "colorize"

require_relative "Goods"

class Clothes < Goods
    attr_accessor :colour, :size

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
        "Price:".colorize(:yellow) + " $#{"%.2f" % @price}"
    end

    def display_details_one_line
        return "Name:".colorize(:yellow) + " #{@name}" + " Brand:".colorize(:yellow) + " #{@brand}" + " Type:".colorize(:yellow) + " #{@type}" + " Colour:".colorize(:yellow) + " #{@colour}" + " Size:".colorize(:yellow) + " #{@size}" + " Stock:".colorize(:yellow) + " #{@stock}" + " Price:".colorize(:yellow) + " $#{"%.2f" % @price}"
    end
end