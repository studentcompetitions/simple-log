class WorkMonthsController < ApplicationController
  before_action :set_month, only: [:index, :show, :new]
  before_action :set_work_month, only: [:show, :edit, :update, :destroy]

  # GET /work_months
  # GET /work_months.json
  def index
    @work_months = WorkMonth.includes(:work_days).where(year: @year, month: @month)
  end

  # GET /work_months/1
  # GET /work_months/1.json
  def show
    @work_days = @work_month.work_days.where("absence IS NOT NULL OR hours IS NOT NULL")
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

  # GET /work_months/1/edit
  def edit
  end

  # POST /work_months
  # POST /work_months.json
  def create
    @work_month = WorkMonth.new(work_month_params)

    respond_to do |format|
      if @work_month.save
        format.html { redirect_to @work_month, notice: 'Work month was successfully created.' }
        format.json { render :show, status: :created, location: @work_month }
      else
        format.html { render :new }
        format.json { render json: @work_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_months/1
  # PATCH/PUT /work_months/1.json
  def update
    respond_to do |format|
      if @work_month.update(work_month_params)
        format.html { redirect_to @work_month, notice: 'Work month was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_month }
      else
        format.html { render :edit }
        format.json { render json: @work_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_months/1
  # DELETE /work_months/1.json
  def destroy
    @work_month.destroy
    respond_to do |format|
      format.html { redirect_to work_months_url, notice: 'Work month was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    params.require(:work_month).permit(:name, :year, :month, work_days_attributes: [:absence, :hours, :date])
  end

  def default_absence_status(date)
    :weekend_or_public_holiday if weekend?(date)
  end

  def weekend?(date)
    date.saturday? || date.sunday?
  end
end
