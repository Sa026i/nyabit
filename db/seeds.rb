# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


[
    { code: "BC", name: "Black Cat" },
    { code: "WC", name: "White Cat" },
    { code: "OC", name: "Orange Cat" },
    { code: "HC", name: "Hachiware Cat" },
    { code: "SC", name: "Shamu Cat" },
    { code: "GD", name: "Golden Dog" },
    { code: "RP", name: "Red Panda" },
].each do |cats|
    partner = Partner.find_or_initialize_by(code: cats[:code])
    partner.update!(cats)
end
