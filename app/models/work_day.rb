class WorkDay < ActiveRecord::Base
  enum absence: { sick: 0, vacation: 1, home_with_sick_child: 2, parental_leave: 3 }

  belongs_to :work_month

  validates :date, presence: true
  validates :hours, numericality: { less_than_or_equal_to: 8 }, if: :hours_present?

  private

  def hours_present?
    hours.present?
  end
end
