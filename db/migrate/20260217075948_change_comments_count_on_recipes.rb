class ChangeCommentsCountOnRecipes < ActiveRecord::Migration[7.1]
  def up
    Recipe.where(comments_count: nil).update_all(comments_count: 0)
    change_column_default :recipes, :comments_count, 0
    change_column_null :recipes, :comments_count, false
  end

  def down
    change_column_null :recipes, :comments_count, true
    change_column_default :recipes, :comments_count, nil
  end
end
