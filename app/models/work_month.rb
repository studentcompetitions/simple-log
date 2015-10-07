class WorkMonth < ActiveRecord::Base
  has_many :work_days, dependent: :destroy

  accepts_nested_attributes_for :work_days

  validates :name, presence: true
  validates :year, presence: true
  validates :month, presence: true

  def sick_days
    work_days.where(absence: WorkDay.absences[:sick]).count
  end

  def vacation_days
    work_days.where(absence: WorkDay.absences[:vacation]).count
  end

  def home_with_sick_child_days
    work_days.where(absence: WorkDay.absences[:home_with_sick_child]).count
  end

  def parental_leave_days
    work_days.where(absence: WorkDay.absences[:parental_leave]).count
  end

  def total_hours
    work_days.where.not(absence: nil).sum(:hours)
  end
end
