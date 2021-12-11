require_relative "./classes/Wardrobe"

def main
    wardrobe = Wardrobe.new
end

main

# READING FROM JSON
# file = File.read("file.json")
# hash = JSON.parse(file)

# WRITING TO JSON
# File.open("file.json", "w") do |file|
#     file.write(hash.to_json)
# end