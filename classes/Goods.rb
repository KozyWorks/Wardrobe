class Goods
    attr_accessor :name, :brand, :type, :stock, :price

    def initialize(name="", brand="", type="", stock=0, price=0.00)
        @name = name
        @brand = brand
        @type = type
        @stock = stock
        @price = price
    end

    def display_details
    end
    
    def display_details_one_line
    end
end