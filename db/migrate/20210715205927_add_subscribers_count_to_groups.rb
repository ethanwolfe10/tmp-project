class AddSubscribersCountToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :subscribers_count, :integer, default: 0
  end
end
