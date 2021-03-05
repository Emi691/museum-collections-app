class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :creator
      t.text :description
      t.string :medium
      t.string :dimensions
      t.decimal :weight
      t.text :condition
      t.integer :hours_shown
      t.boolean :showing
      t.string :location
      t.text :provenance
      t.decimal :appraised_value
      t.integer :user_id
      t.text :notes
      t.timestamps null: false
    end
  end
end
