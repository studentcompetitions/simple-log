class Employee < ActiveRecord::Base
  validates :name, presence: true

  has_many :work_months, dependent: :destroy
end
