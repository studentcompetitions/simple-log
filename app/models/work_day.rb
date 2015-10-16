class WorkDay < ActiveRecord::Base
  enum absence: { sick: 0, vacation: 1, home_with_sick_child: 2, parental_leave: 3 }

  belongs_to :work_month

  validates :date, presence: true
  validates :absence, presence: true, if: :hours_present?
  validates :hours,
    numericality: { only_integer: true, less_than_or_equal_to: 8, greater_than: 0, allow_nil: false },
    if: :absence?

  private

  def hours_present?
    hours.present?
  end
end
