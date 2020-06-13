class AddActionTypetoVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :action_type, :string
    add_column :photos, :action_type, :string
  end
end
