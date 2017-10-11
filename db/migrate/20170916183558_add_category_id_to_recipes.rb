class AddCategoryIdToRecipes < ActiveRecord::Migration
  def change
    add_reference :recipes, :category, index: true
  end
end
