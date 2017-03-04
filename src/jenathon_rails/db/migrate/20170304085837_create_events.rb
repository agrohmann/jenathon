class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.float :latitude, :index => true
      t.float :longitude, :index => true
      t.string :title
      t.text :description
      t.string :category, :index => true
      t.datetime :targeted_at, :index => true
      t.string :address, :index => true

      t.timestamps
    end
  end
end
