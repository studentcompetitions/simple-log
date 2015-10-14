class RemoveNameFromWorkMonths < ActiveRecord::Migration
  def change
    remove_column :work_months, :name, :string
  end
end
