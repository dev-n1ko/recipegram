class AddTitleKanaToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :title_kana, :string
    add_index :recipes, :title_kana
  end
end
