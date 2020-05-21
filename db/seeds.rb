# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

def create_ingredients
  ingredient_list_json = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read

  ingredient_list = JSON.parse(ingredient_list_json)

  ingredient_list["drinks"].each do |el| 
    new_ingredient = Ingredient.new(name: el["strIngredient1"])
    new_ingredient.save!
  end
end

def create_cocktails
  new_cocktail = Cocktail.new(name: 'vrebse')
  new_cocktail.save!
  (2..5).to_a.sample.times do
    new_dose = Dose.new(description: "oaenronfe", ingredient: Ingredient.all.sample, cocktail: new_cocktail)
    new_dose.save!
  end
end

create_cocktails