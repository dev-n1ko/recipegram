class AddFollowCountsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :following_count, :integer
    add_column :users, :followers_count, :integer
  end
end
