require "credit_card_validations"

require_relative "Hat"
require_relative "Top"
require_relative "Pants"
require_relative "Shoes"

FILE_PATH = "./clothes/"

class Wardrobe
    @@user_type = ""

    @@clothes = {
        :hat => [],
        :top => [],
        :pants => [],
        :shoes => [],
    }

    def self.clothes
        @@clothes
    end

    def initialize
        retrive_data_from_files

        run_program
    end
    
    def retrive_data_from_files
        Dir.foreach(FILE_PATH) do |filename|
            next if filename == '.' or filename == '..'
            next if File.empty?(FILE_PATH + filename)

            category = filename.gsub(".txt", "")
            
            file = File.open(FILE_PATH + filename)

            file.each_line do |line|
                details = []
                line.chomp.split("　").each do |detail|
                    key, value = detail.split(":")

                    if key == "size" or key == "stock"
                        value = value.to_i
                    elsif key == "price"
                        value = value.to_f
                    end

                    details << value
                end

                @@clothes[category.to_sym] << Object.const_get(category.capitalize).new(*details)
            end

            file.close
        end
    end

    def run_program
        puts "Welcome!!!"

        choose_the_user_type
    end

    def choose_the_user_type
        option = nil
        begin
            puts "Please choose from the following options!"
            create_menu(["Clerk", "Customer", "Exit the program"])

            option = Integer(option = gets.chomp)

            case option
            when 1
                @@user_type = "clerk"

                menu_for_clerk
            when 2
                @@user_type = "customer"

                @shopping_cart = []

                menu_for_customer
            when 3
                exit_program
            else
                raise ArgumentError
            end
        rescue ArgumentError
            puts ""
            puts "\"#{option}\" is not a valid option!"
            puts ""

            retry
        end
    end

    def menu_for_clerk
        loop do
            puts ""

            option = nil
            begin
                puts "You are on the clerk's menu!"
                puts "Please choose from the following options!"
                create_menu(["Show all items", "Add new item", "Exit the program"])

                option = Integer(option = gets.chomp)

                case option
                when 1
                    show_all_items
                when 2
                    add_new_item
                when 3
                    exit_program
                else
                    raise ArgumentError
                end
            rescue ArgumentError
                puts ""
                puts "\"#{option}\" is not a valid option!"
                puts ""

                retry
            end
        end
    end

    def menu_for_customer
        loop do
            puts ""

            option = nil
            begin
                puts "You are on the customer's menu!"
                puts "Please choose from the following options!"
                create_menu(["Show all items", "Show shopping cart", "Exit the program"])

                option = Integer(option = gets.chomp)

                case option
                when 1
                    show_all_items
                when 2
                    show_shopping_cart
                when 3
                    exit_program
                else
                    raise ArgumentError
                end
            rescue ArgumentError
                puts ""
                puts "\"#{option}\" is not a valid option!"
                puts ""

                retry
            end
        end
    end

    def exit_program
        update_database

        puts ""
        puts "Thank you!"
        puts ""

        exit(0)
    end

    def show_all_items
        puts ""

        @@clothes.each do |category, items|
            next if items.empty?
            
            puts "=============================================".colorize(:blue)
            puts "== #{category.to_s.upcase}".colorize(:blue)
            puts "=============================================".colorize(:blue)
            
            items.each_with_index do |item, index|
                puts "" if item == items[0]
                puts "[#{index + 1}]".colorize(:green)
                puts item.display_details
                puts "" if item != items[-1]
            end

            puts ""
        end

        puts "What would you like to do now?"
        option = nil
        begin
            loop do
                puts "Please choose from the following options!"
                if @@user_type == "clerk"
                    create_menu(["Delete item", "Return to the previous menu"])
                elsif @@user_type == "customer"
                    create_menu(["Add item to shopping cart", "Return to the previous menu"])
                end

                option = Integer(option = gets.chomp)

                case option
                when 1
                    if @@user_type == "clerk"
                        delete_item
                    elsif @@user_type == "customer"
                        add_item_to_shopping_cart
                    end
                when 2
                    return
                else
                    raise ArgumentError
                end
            end
        rescue ArgumentError
            puts ""
            puts "\"#{option}\" is not a valid option!"
            puts ""

            retry
        end
    end

    def delete_item
        puts ""
        category = nil
        begin
            puts "From which category are you willing to delete an item from?"
            create_menu(["Hat", "Top", "Pants", "Shoes", "Return to the previous menu"])

            category = Integer(category = gets.chomp)

            if category.between?(1, 5) == false
                raise ArgumentError
            else
                case category
                when 1
                    category = "hat"
                when 2
                    category = "top"
                when 3
                    category = "pants"
                when 4
                    category = "shoes"
                when 5
                    puts ""

                    return
                end

                raise ArgumentError if @@clothes[category.to_sym].size < 1
            end
        rescue ArgumentError
            puts ""
            if (category == "hat" || category == "top" || category == "pants" || category == "shoes")
                puts "No item exists to delete for \"#{category.capitalize}\"!"
            else
                puts "\"#{category}\" is not a valid option!"
            end
            puts ""

            retry
        end

        clothes = @@clothes[category.to_sym]

        puts ""
        index = nil
        begin
            puts "Please choose an item from the following:"

            clothes.each_with_index do |item, i|
                puts "[#{i + 1}]".colorize(:green) + " #{item.display_details_one_line}"
            end
            print "> ".colorize(:light_red)

            index = Integer(index = gets.chomp)

            if index.between?(1, clothes.size) == false
                raise ArgumentError
            else
                clothes.delete_at(index - 1)

                puts ""
                puts "The item has been successfully deleted!"
            end
        rescue ArgumentError
            puts ""
            puts "\"#{index}\" is not a valid option!"
            puts ""

            retry
        end

        puts ""
    end

    def add_item_to_shopping_cart
        puts ""
        category = nil
        begin
            puts "From which category are you willing to add an item to shopping cart from?"
            create_menu(["Hat", "Top", "Pants", "Shoes", "Return to the previous menu"])

            category = Integer(category = gets.chomp)

            if category.between?(1, 5) == false
                raise ArgumentError
            else
                case category
                when 1
                    category = "hat"
                when 2
                    category = "top"
                when 3
                    category = "pants"
                when 4
                    category = "shoes"
                when 5
                    puts ""

                    return
                end

                raise ArgumentError if @@clothes[category.to_sym].size < 1
            end
        rescue ArgumentError
            puts ""
            puts "\"#{category}\" is not a valid option!"
            puts ""

            retry
        end

        clothes = @@clothes[category.to_sym]

        puts ""
        index = nil
        begin
            puts "Please choose an item from the following:"

            clothes.each_with_index do |item, i|
                puts "[#{i + 1}]".colorize(:green) + " #{item.display_details_one_line}"
            end
            print "> ".colorize(:light_red)

            index = Integer(index = gets.chomp)

            if index.between?(1, clothes.size) == false
                raise ArgumentError
            else
                @shopping_cart << clothes[index - 1]

                puts ""
                puts "The item has been successfully added to your shopping cart!"
            end
        rescue ArgumentError
            puts ""
            puts "\"#{index}\" is not a valid option!"
            puts ""

            retry
        end

        puts ""
        
        return
    end

    def add_new_item
        puts ""
        category = nil
        begin
            puts "Which category are you willing to add an item to?"
            create_menu(["Hat", "Top", "Pants", "Shoes", "Return to the previous menu"])

            category = Integer(category = gets.chomp)

            if category.between?(1, 5) == false
                raise ArgumentError
            else
                case category
                when 1
                    category = "hat"
                when 2
                    category = "top"
                when 3
                    category = "pants"
                when 4
                    category = "shoes"
                when 5
                    puts ""

                    return
                end
            end
        rescue ArgumentError
            puts ""
            puts "\"#{category}\" is not a valid option!"
            puts ""

            retry
        end

        puts ""
        puts "Please enter the following details:"

        print "Name? ".colorize(:light_red)
        name = gets.chomp

        puts ""
        print "Brand? ".colorize(:light_red)
        brand = gets.chomp

        puts ""
        print "Type? ".colorize(:light_red)
        type = gets.chomp

        puts ""
        print "Colour? ".colorize(:light_red)
        colour = gets.chomp

        puts ""
        size = nil
        begin
            print "Size? ".colorize(:light_red)

            size = Integer(size = gets.chomp)
        rescue ArgumentError
            puts ""
            puts "\"#{size}\" is not a valid input!"
            puts ""

            retry
        end

        puts ""
        stock = nil
        begin
            print "Stock? ".colorize(:light_red)

            stock = Integer(stock = gets.chomp)
        rescue ArgumentError
            puts ""
            puts "\"#{stock}\" is not a valid input!"
            puts ""

            retry
        end

        puts ""
        price = nil
        begin
            print "Price? ".colorize(:light_red)

            price = Float(price = gets.chomp)
        rescue ArgumentError
            puts ""
            puts "\"#{price}\" is not a valid input!"
            puts ""

            retry
        end

        @@clothes[category.to_sym] << Object.const_get(category.capitalize).new(name, brand, type, colour, size, stock, price)
        
        return
    end

    def show_shopping_cart
        puts ""

        if @shopping_cart.size < 1
            puts "Your shopping cart is empty!"

            return
        end
        
        puts "=============================================".colorize(:blue)
        puts "== SHOPPING CART".colorize(:blue)
        puts "=============================================".colorize(:blue)
        puts ""

        @shopping_cart.each_with_index do |item, index|
            puts "[#{index + 1}]".colorize(:green)
            puts item.display_details
            puts ""
        end

        puts "What would you like to do now?"
        option = nil
        begin
            loop do
                create_menu(["Remove item from the shopping cart", "Make a payment", "Return to the previous menu"])

                option = Integer(option = gets.chomp)

                case option
                when 1
                    remove_item_from_shopping_cart
                when 2
                    make_payment
                when 3
                    return
                else
                    raise ArgumentError
                end
            end
        rescue ArgumentError
            puts ""
            puts "\"#{option}\" is not a valid option!"
            puts ""

            retry
        end
        
        return
    end

    def remove_item_from_shopping_cart
        puts ""
        puts "remove_item_from_shopping_cart"
        puts ""
        
        return
    end

    def make_payment
        total_cost = 0.00
        @shopping_cart.each do |item|
            total_cost += item.price
        end
        total_cost = total_cost.round(2)

        puts ""
        puts "The total cost is $#{total_cost}."
        
        puts ""
        puts "Please enter the following card details:"

        
        
        return
    end

    def create_menu(menu)
        menu.each_with_index do |item, index|
            puts "[#{index + 1}]".colorize(:green) + " #{item}"
        end

        print "> ".colorize(:light_red)
    end

    def update_database
        Dir.foreach(FILE_PATH) do |filename|
            next if filename == '.' or filename == '..'
            next if File.empty?(FILE_PATH + filename)

            category = filename.gsub(".txt", "")
            items = @@clothes[category.to_sym]

            next if items.empty?
            
            file = File.open(FILE_PATH + filename, "w+")

            items.each do |item|
                file.puts("name:#{item.name}　brand:#{item.brand}　type:#{item.type}　colour:#{item.colour}　size:#{item.size}　stock:#{item.stock}　price:#{item.price}")
            end

            file.close
        end
    end
end