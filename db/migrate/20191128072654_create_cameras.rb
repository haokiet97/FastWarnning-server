class CreateCameras < ActiveRecord::Migration[5.2]
  def change
    create_table :cameras do |t|
      t.string :title
      t.string :token
      t.string :info
      t.references :user

      t.timestamps
    end
  end
end
