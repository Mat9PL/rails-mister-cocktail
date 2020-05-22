# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

Dose.delete_all
Cocktail.delete_all
Ingredient.delete_all

def create_all_ingredients
  ingredient_list_json = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read

  ingredient_list = JSON.parse(ingredient_list_json)

  ingredient_list["drinks"].each do |el| 
    new_ingredient = Ingredient.new(name: el["strIngredient1"])
    new_ingredient.save!
  end
end

def create_cocktail
  name = Faker::Hipster.words(number: (2..4).to_a.sample).join(" ").capitalize
  new_cocktail = Cocktail.new(name: name)
  new_cocktail.save!
  description = Faker::Hipster.words(number: (3..7).to_a.sample).join(" ").capitalize
  ingredients = Ingredient.all

  (2..5).to_a.sample.times do
    ingredient = ingredients.sample
    new_dose = Dose.new(description: description, ingredient: ingredients.sample, cocktail: new_cocktail)
    new_dose.save!
    ingredients -= [ingredient]
  end
end

create_all_ingredients

15.times { create_cocktail }
