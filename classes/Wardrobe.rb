require_relative "Hat"
require_relative "Top"
require_relative "Pants"
require_relative "Shoes"

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
        Dir.foreach("./clothes") do |filename|
            next if filename == '.' or filename == '..'
            next if File.empty?("./clothes/" + filename)

            category = filename.gsub(".txt", "")
            
            file = File.open("./clothes/" + filename)

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
            puts "From which category are you willing to delete item from?"
            create_menu(["Hat", "Top", "Pants", "Shoes"])

            category = Integer(category = gets.chomp)

            if category.between?(1, 4) == false
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
                end

                raise ArgumentError if @@clothes[category.to_sym].size < 1
            end
        rescue ArgumentError
            puts ""
            if (category == "hat" || category == "top" || category == "pants" || category == "shoes")
                puts "No item exists to delete for \"#{category}\"!"
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
        puts "add_item_to_shopping_cart"
        
        return
    end

    def add_new_item
        puts ""
        puts "add_new_item"
        
        return
    end

    def show_shopping_cart
        puts ""
        puts "show_shopping_cart"
        
        return
    end

    def make_payment
        puts ""
        puts "make_payment"
        
        return
    end

    def create_menu(menu)
        menu.each_with_index do |item, index|
            puts "[#{index + 1}]".colorize(:green) + " #{item}"
        end

        print "> ".colorize(:light_red)
    end
end