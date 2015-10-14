class WorkMonthsController < ApplicationController
  before_action :set_month, only: [:index, :show, :new]
  before_action :set_work_month, only: [:show, :edit, :update, :destroy]

  # GET /work_months
  # GET /work_months.json
  def index
    @work_months = WorkMonth.includes(:work_days, :employee).where(year: @year, month: @month).to_a.
      sort_by { |m| m.has_absence? ? 0 : 1 }
    @reported_count = @work_months.count
    @employees_count = Employee.count
    @missing = Employee.where.not(id: @work_months.map(&:employee_id)).pluck(:name)
  end

  # GET /work_months/1
  # GET /work_months/1.json
  def show
    @work_days = @work_month.work_days
  end

  # GET /work_months/new
  def new
    month_start = Date.new(@year, @month, 1)
    month_end = month_start.end_of_month

    @work_month = WorkMonth.new(year: @year, month: @month)
    @work_month.work_days = (month_start..month_end).map do |date|
      WorkDay.new(date: date)
    end
  end

  # POST /work_months
  # POST /work_months.json
  def create
    @work_month = WorkMonth.new(work_month_params)

    respond_to do |format|
      if @work_month.save
        format.html { redirect_to @work_month, notice: "Your absence was successfully logged." }
        format.json { render :show, status: :created, location: @work_month }
      else
        format.html { render :new }
        format.json { render json: @work_month.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_month.destroy

    if referer_action == "index"
      redirect_path = list_absence_url(month: "#{@work_month.year}-#{@work_month.month}")
    else
      redirect_path = log_absence_url(month: "#{@work_month.year}-#{@work_month.month}")
    end

    redirect_to redirect_path, notice: "Absence was successfully deleted."
  end

  private

  def set_month
    if params[:month].present?
      @year, @month = params[:month].split("-").map(&:to_i)
    else
      @year = Date.today.year
      @month = Date.today.month
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_work_month
    @work_month = WorkMonth.includes(:work_days).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def work_month_params
    params.require(:work_month).permit(:name, :year, :month, :employee_id, work_days_attributes: [:absence, :hours, :date])
  end

  def default_absence_status(date)
    :weekend_or_public_holiday if weekend?(date)
  end

  def weekend?(date)
    date.saturday? || date.sunday?
  end

  def referer_action
    Rails.application.routes.recognize_path(request.referer)[:action]
  end
end
