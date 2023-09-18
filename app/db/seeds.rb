# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Product.destroy_all
Category.destroy_all

categories = [
             "Panaderia",
             "Cafeteria",
             "Sandwiches",
             "Entradas",
             "Bebidas Sin Alcohol",
             "Plato Principal"
            ]
            
categories.each do |category|
     Category.create!(name: category)
end

100.times do |index|
     Product.create!(title: Faker::Name.name,
                   description: Faker::Lorem.paragraph,
                   price: Faker::Number.number(digits: 4),
                   category_id: rand(1..6))
                  
   end