class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.date :rate_date
      t.string :base
      t.string :target
      t.float :value

      t.timestamps
    end
  end
end
