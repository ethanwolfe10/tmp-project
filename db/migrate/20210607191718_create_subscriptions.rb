class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :moderator
      t.boolean :confirmed
      t.string :status

      t.timestamps
    end
  end
end
