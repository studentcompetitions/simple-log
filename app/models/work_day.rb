class WorkDay < ActiveRecord::Base
  enum absence: [:sick, :vacation, :home_with_sick_child, :parental_leave]

  belongs_to :work_month
end
