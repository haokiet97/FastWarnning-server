class AddLocationRefToCameras < ActiveRecord::Migration[5.2]
  def change
    add_reference :cameras, :location, foreign_key: true
  end
end
