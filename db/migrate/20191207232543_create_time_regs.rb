class CreateTimeRegs < ActiveRecord::Migration[6.0]
  def change
    create_table :time_regs do |t|
      t.timestamp :time_reg
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
