class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :user_id
      t.datetime :start
      t.datetime :finish
      t.decimal :break_length

      t.timestamps
    end
  end
end
