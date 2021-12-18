require_relative "Hat"
require_relative "Top"
require_relative "Pants"
require_relative "Shoes"

class Wardrobe
    @@user_type = nil

    @@clothes = {
        :hat => [],
        :top => [],
        :pants => [],
        :shoes => [],
    }

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

                add_new_item(Object.const_get(category.capitalize).new(*details))
            end

            file.close
        end
    end

    def run_program
        puts "Welcome!!!"

        @@user_type = choose_the_user_type
        if @@user_type == "clerk"
            puts ""
            menu_for_clerk
        elsif @@user_type == "customer"
            puts ""
            menu_for_customer
        end
    end

    def choose_the_user_type
        option = nil
        begin
            puts "Please choose from the following options!"
            puts "[1] Clerk"
            puts "[2] Customer"
            puts "[3] Exit the program"
            print "> "

            case Integer(option = gets.chomp)
            when 1
                return "clerk"
            when 2
                return "customer"
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
        option = nil
        begin
            puts "You are on the clerk's menu!"
            puts "Please choose from the following options!"
            puts "[1] Show all items"
            puts "[2] Add new item"
            puts "[3] Exit the program"
            print "> "

            case Integer(option = gets.chomp)
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

    def menu_for_customer
        option = nil
        begin
            puts "You are on the customer's menu!"
            puts "Please choose from the following options!"
            puts "[1] Show all items"
            puts "[2] Add new item"
            puts "[3] Exit the program"
            print "> "

            case Integer(option = gets.chomp)
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

    def exit_program
        puts ""
        puts "Thank you!"
        puts ""

        exit(0)
    end

    def show_all_items
        puts ""

        @@clothes.each do |category, items|
            puts "============================================="
            puts category.upcase
            puts "============================================="

            items.each_with_index do |item, index|
                puts item.display_details
                puts "" if item != items[-1]
            end

            puts ""
        end
    end

    def delete_item

    end

    def add_item_to_shopping_cart

    end

    def add_new_item(item)
        @@clothes[item.class.to_s.downcase.to_sym] << item
    end

    def show_shopping_cart

    end
end