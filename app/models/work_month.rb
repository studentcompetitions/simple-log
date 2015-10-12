class WorkMonth < ActiveRecord::Base
  has_many :work_days, dependent: :destroy

  accepts_nested_attributes_for :work_days

  validates :name, presence: true
  validates :year, presence: true
  validates :month, presence: true

  def sick_days
    work_days_array.count { |d| d.absence == "sick" }
  end

  def vacation_days
    work_days_array.count { |d| d.absence == "vacation" }
  end

  def home_with_sick_child_days
    work_days_array.count { |d| d.absence == "home_with_sick_child" }
  end

  def parental_leave_days
    work_days_array.count { |d| d.absence == "parental_leave" }
  end

  def absence_days
    work_days_array.count { |d| d.absence.present? }
  end

  def absence_hours
    work_days_array.select(&:hours).sum(&:hours)
  end

  private

  def work_days_array
    @work_days_array ||= work_days.to_a
  end
end
