class ChangeOnFavorites < ActiveRecord::Migration[7.1]
  def change
    add_index :favorites, [:user_id, :recipe_id], unique: true
  end
end
