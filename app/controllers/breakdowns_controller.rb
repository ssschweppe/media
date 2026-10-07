class BreakdownsController < ApplicationController
  before_action :set_breakdown, only: %i[ show edit update destroy ]

  # GET /breakdowns or /breakdowns.json
  def index
    @breakdowns = Breakdown.all
  end

  # GET /breakdowns/1 or /breakdowns/1.json
  def show
  end

  # GET /breakdowns/new
  def new
    @breakdown = Breakdown.new
  end

  # GET /breakdowns/1/edit
  def edit
  end

  # POST /breakdowns or /breakdowns.json
  def create
    @breakdown = Breakdown.new(breakdown_params)

    respond_to do |format|
      if @breakdown.save
        format.html { redirect_to @breakdown, notice: "Breakdown was successfully created." }
        format.json { render :show, status: :created, location: @breakdown }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @breakdown.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /breakdowns/1 or /breakdowns/1.json
  def update
    respond_to do |format|
      if @breakdown.update(breakdown_params)
        format.html { redirect_to @breakdown, notice: "Breakdown was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @breakdown }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @breakdown.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /breakdowns/1 or /breakdowns/1.json
  def destroy
    @breakdown.destroy!

    respond_to do |format|
      format.html { redirect_to breakdowns_path, notice: "Breakdown was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_breakdown
      @breakdown = Breakdown.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def breakdown_params
      params.expect(breakdown: [ :title, :lead, :body, :demo_key, :published_at, :pattern_id, :example_id ])
    end
end
