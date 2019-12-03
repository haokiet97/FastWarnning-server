class EditColumnsNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :read
    add_column :notifications, :read, :boolean, default: false
  end
end
