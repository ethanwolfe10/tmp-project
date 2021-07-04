class AddStatusColorToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :status_color, :string, default: '#000000'
  end
end
