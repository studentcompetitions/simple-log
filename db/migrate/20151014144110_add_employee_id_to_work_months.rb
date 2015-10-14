class AddEmployeeIdToWorkMonths < ActiveRecord::Migration
  def change
    add_column :work_months, :employee_id, :integer, null: false
    add_index :work_months, :employee_id
  end
end
