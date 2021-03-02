class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|

      t.timestamps null: false
    end
  end
end
