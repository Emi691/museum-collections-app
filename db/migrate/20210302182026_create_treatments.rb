class CreateTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :treatments do |t|
      t.text :description
      t.text :start_condition
      t.text :end_condition
      t.boolean :done
      t.integer :object_id
      t.timestamps null: false
    end
  end
end
