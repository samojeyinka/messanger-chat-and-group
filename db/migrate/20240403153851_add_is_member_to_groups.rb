class AddIsMemberToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :isMember, :boolean, default: false
  end
end
