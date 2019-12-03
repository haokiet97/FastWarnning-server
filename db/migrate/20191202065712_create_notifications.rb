class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user
      t.string :notifiable_type
      t.integer :notifiable_id
      t.string :notice
      t.boolean :read, default: true

      t.timestamps
    end
  end
end
