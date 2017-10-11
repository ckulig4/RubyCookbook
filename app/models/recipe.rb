class Recipe < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :ingredients, :instructions, :category
  
  def self.find_all_by_query(query)
    query = query.downcase
    query = "%#{query}%"
#    categoryQuery = categoryQuery.downcase
#    categoryQuery = "%#{categoryQuery}%"
    
    Recipe.where(['lower(title) like ?
                  OR lower(ingredients) like ?
                  OR lower(instructions) like ?',
                  query, query, query])
  end
end