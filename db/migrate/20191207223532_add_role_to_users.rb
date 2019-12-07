class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :integer, default: 2
    add_column :users, :hours_per_week, :integer, default: 40
  end
end
