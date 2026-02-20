class ChengeFollowcount < ActiveRecord::Migration[7.1]
  def up
    User.where(following_count: nil).update_all(following_count: 0)
    User.where(followers_count: nil).update_all(followers_count: 0)

    change_column_default :users, :following_count, 0
    change_column_null :users, :following_count, false

    change_column_default :users, :followers_count, 0
    change_column_null :users, :followers_count, false
  end

  def down
    change_column_null :users, :following_count, true
    change_column_default :users, :following_count, nil

    change_column_null :users, :followers_count, true
    change_column_default :users, :followers_count, nil
  end
end