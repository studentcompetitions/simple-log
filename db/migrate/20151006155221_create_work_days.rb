class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.integer :work_month_id, null: false
      t.integer :absence
      t.integer :hours
      t.date :date

      t.timestamps null: false
    end
  end
end
