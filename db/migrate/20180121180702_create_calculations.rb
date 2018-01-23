class CreateCalculations < ActiveRecord::Migration[5.1]
  def change
    create_table :calculations do |t|
      t.integer :user_id
      t.string :base_currency
      t.string :target_currency
      t.float :rate_on_create
      t.integer :amount
      t.integer :max_weeks
      t.jsonb :rates_data

      t.timestamps
    end
  end
end
