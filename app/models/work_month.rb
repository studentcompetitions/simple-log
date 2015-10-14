class WorkMonth < ActiveRecord::Base
  has_many :work_days, dependent: :destroy
  belongs_to :employee

  accepts_nested_attributes_for :work_days

  validates :year, presence: true
  validates :month, presence: true
  validates :employee_id,
    uniqueness: {
      scope: [:year, :month],
      message: "You have already logged your absence for this month."
    },
    presence: {
      message: "Please tell us who you are!"
    }

  before_save :drop_empty_work_days

  delegate :name, to: :employee

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

  def has_absence?
    work_days.any?
  end

  private

  def work_days_array
    @work_days_array ||= work_days.to_a
  end

  def drop_empty_work_days
    self.work_days = work_days.to_a.delete_if { |d| d.absence.blank? && d.hours.blank? }
  end
end
