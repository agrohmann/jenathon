class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.float :latitude
      t.float :longitude
      t.string :title
      t.text :description
      t.string :category
      t.datetime :targeted_at

      t.timestamps
    end
  end
end
