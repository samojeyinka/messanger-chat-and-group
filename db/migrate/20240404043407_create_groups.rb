class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :is_private,:default => false

      t.timestamps
    end
  end
end
