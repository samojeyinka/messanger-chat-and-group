class AddDescriptionToGroup < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :description, :text
  end
end
