class CreateDays < ActiveRecord::Migration[6.0]
  def change
    create_table :days do |t|
      t.date :date_reg
      t.integer :month
      t.integer :week
      t.integer :seconds
      t.boolean :odd
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
