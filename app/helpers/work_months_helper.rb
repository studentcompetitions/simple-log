module WorkMonthsHelper
  def employees_select_options
    Employee.all.collect { |e| [ e.name, e.id ] }
  end
end
