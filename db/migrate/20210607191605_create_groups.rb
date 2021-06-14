class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :bio
      t.integer :mod_id

      t.timestamps
    end
  end
end
