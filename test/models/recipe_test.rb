require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "creates a valid record" do
    recipe = Recipe.new
    recipe.title = "Ice water"
    recipe.ingredients = ["one glass","water","ice"].join("<br>")
    recipe.instructions = "Combine all ingredients into the glass and let sit for two minutes. Serve immediately."
    recipe.category_id = categories(:one).id
    assert recipe.save
  end

  test "should not save unless title is filled in" do
    recipe = Recipe.new
    assert !recipe.save # save should fail because there are errors.
    assert recipe.errors[:title].include?("can't be blank")
  end
  
  test "should not save unless ingredients is filled in" do
    recipe = Recipe.new
    assert !recipe.save # save should fail because there are errors.
    assert recipe.errors[:ingredients].include?("can't be blank")
  end
  
  test "should not save unless instructions is filled in" do
    recipe = Recipe.new
    assert !recipe.save # save should fail because there are errors.
    assert recipe.errors[:instructions].include?("can't be blank")
  end
  
  test "should only have one recipe with the same name" do
    recipe = Recipe.new(:title =>"Toast")
    recipe.valid?
    assert recipe.valid?().eql?(false)
  end
  
  test "creates a valid record with a category selected" do
    recipe = Recipe.new
    recipe.title = "RumNCoke"
    recipe.calories = "220"
    recipe.ingredients = ["one glass","rum","ice","coke"].join("<br>")
    recipe.instructions = "Add ice to glass. Fill glass half full with coke and the other half with rum. Serve immediately."
    recipe.category_id = categories(:one).id
    assert recipe.save
  end

  test "should find a match on title" do
    test_recipe = Recipe.create(title: "Cake", ingredients: "Flour, sugar, eggs.", instructions: "Mix ingredients...", calories: "500", category: "Deserts")
    assert_equal test_recipe, Recipe.find_all_by_query("cake").first
  end

  test "should find 2 matches on title" do
    Recipe.create!(title: "Cake", ingredients: "Flour, sugar, eggs.", instructions: "Mix ingredients...", calories: "500", category: "Deserts")
    Recipe.create!(title: "Pancakes", ingredients: "flour, butter, eggs.", instructions: "Mix ingredients in a large bowl...", calories: "125", category: "Breakfast")
    
    assert_equal 2, Recipe.find_all_by_query("cake").count
  end
  
  test "should find a match on ingredients" do
    test_recipe = Recipe.create(title: "Cake", ingredients: "Flour, sugar, eggs.", instructions: "Mix ingredients...", calories: "500", category: "Deserts")
    
    assert_equal test_recipe, Recipe.find_all_by_query("flour").first
  end
  
  test "should find a match on instructions" do
    test_recipe = Recipe.create(title: "Cake", ingredients: "Flour, sugar, eggs.", instructions: "Mix ingredients...", calories: "500", category: "Deserts")
  
    assert_equal test_recipe, Recipe.find_all_by_query("mix").first
  end
  
end




