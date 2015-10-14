class AddIndexToWorkDays < ActiveRecord::Migration
  def change
    add_index :work_days, :work_month_id
  end
end
