require_relative "../classes/Wardrobe.rb"

describe "Wardrobe" do
    it "should be defined" do
        expect(defined?(initialize)).to eql("method")
    end

    it "should have class variable called @@user_type to hold user type of either \"Clerk\" or \"Customer\"" do
        expect(Wardrobe.class_variable_get(:@@user_type)).to eql("")
    end

    describe "@@clothes" do
        it "should be a Hash object to hold data from database" do
            expect(Wardrobe.class_variable_get(:@@clothes).class).to eql(Hash)
        end
    end

    describe "object" do
        before :each do
            @wardrobe = Wardrobe.new
        end
    
        it "should have four different categories like Hat, Top, Pants and Shoes when data is retrived" do
            @wardrobe.retrive_data_from_files
            
            clothes = Wardrobe.class_variable_get(:@@clothes)
        
            expect(clothes.size).to eql(4)
            expect(clothes[:hat].class).to eql(Array)
            expect(clothes[:top].class).to eql(Array)
            expect(clothes[:pants].class).to eql(Array)
            expect(clothes[:shoes].class).to eql(Array)
        end

        it "should update database (.txt) when new item is added" do
            clothes = Wardrobe.class_variable_get(:@@clothes)
            old_database = clothes.clone

            clothes[:hat] << Hat.new("NY Hat", "Nike", "Snapback", "Grey", 5, 10, 59.99)

            @wardrobe.update_database
            @wardrobe.retrive_data_from_files

            expect(old_database[:hat].size).not_to be eq(clothes[:hat].size)
        end

        it "should update database (.txt) when item is removed" do
            clothes = Wardrobe.class_variable_get(:@@clothes)
            old_database = clothes.clone

            clothes[:hat].delete_at(-1)

            @wardrobe.update_database
            @wardrobe.retrive_data_from_files

            expect(old_database[:hat].size).not_to be eq(clothes[:hat].size)
        end
    end
end