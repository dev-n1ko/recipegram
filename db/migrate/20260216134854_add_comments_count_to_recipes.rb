class AddCommentsCountToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :comments_count, :integer
  end
end
