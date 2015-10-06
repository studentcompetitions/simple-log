class WorkDay < ActiveRecord::Base
  enum absence: { sick: 0, vacation: 1, home_with_sick_child: 2, parental_leave: 3, weekend_or_public_holiday: 4 }

  belongs_to :work_month

  validates :date, presence: true
  validates :hours, presence: true, unless: :absence?
end
