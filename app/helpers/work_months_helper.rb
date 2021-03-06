module WorkMonthsHelper
  def employees_select_options
    Employee.order(:name).all.collect { |e| [ e.name, e.id ] }
  end

  def weekend_class(day)
    if day.sunday? || day.saturday?
      "weekend"
    end
  end
end
