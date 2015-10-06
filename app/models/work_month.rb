class WorkMonth < ActiveRecord::Base
  has_many :work_days, dependent: :destroy

  accepts_nested_attributes_for :work_days

  validates :name, presence: true

  def sick_days
    work_days.where(absence: WorkDay.absences[:sick]).count
  end

  def vacation_days
    work_days.where(absence: WorkDay.absences[:vacation]).count
  end
end
