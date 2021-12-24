require_relative "../classes/Clothes.rb"

describe "Clothes" do
    it "should be defined" do
        expect(defined?(initialize)).to eql("method")
    end

    describe "object" do
        before :each do
            @clothes = Clothes.new
        end

        it "should be an instance of a Clothes" do
            expect(@clothes).to be_a(Clothes)
        end
    
        it "should have correct data type for each instance variables" do
            expect(@clothes.name.class).to eq(String)
            expect(@clothes.brand.class).to eq(String)
            expect(@clothes.type.class).to eq(String)
            expect(@clothes.colour.class).to eq(String)
            expect(@clothes.size.class).to eq(Integer)
            expect(@clothes.stock.class).to eq(Integer)
            expect(@clothes.price.class).to eq(Float)
        end

        describe "display_details" do
            it "should return formatted string" do
                expect(@clothes.display_details).to eq("Name:".colorize(:yellow) + " #{@clothes.name} / " +
                    "Brand:".colorize(:yellow) + " #{@clothes.brand}" +
                    "\nType:".colorize(:yellow) + " #{@clothes.type}" +
                    "\nColour:".colorize(:yellow) + " #{@clothes.colour}" +
                    "\nSize:".colorize(:yellow) + " #{@clothes.size}" +
                    "\nStock:".colorize(:yellow) + " #{@clothes.stock} / " +
                    "Price:".colorize(:yellow) + " $#{"%.2f" % @clothes.price}")
            end
        end

        describe "display_details_one_line" do
            it "should return formatted string" do
                expect("Name:".colorize(:yellow) + " #{@clothes.name}" + " Brand:".colorize(:yellow) + " #{@clothes.brand}" + " Type:".colorize(:yellow) + " #{@clothes.type}" + " Colour:".colorize(:yellow) + " #{@clothes.colour}" + " Size:".colorize(:yellow) + " #{@clothes.size}" + " Stock:".colorize(:yellow) + " #{@clothes.stock}" + " Price:".colorize(:yellow) + " $#{"%.2f" % @clothes.price}")
            end
        end
    end
end