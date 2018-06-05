class SessionyearsController < ApplicationController
  before_action :set_sessionyear, only: [:show, :edit, :update, :destroy,
                                          :calendar, :generate_calendar]
  before_action  :authorize

  def calendar

    # Generate stub calendar. Should only be called 1x per SY
    if @sessionyear.sessiondays.count == 0
      CalBuilder.build_draft(@sessionyear)
      @sessionyear.sessiondays.each {|sd| sd.save! }
    end

  end

  # GET /sessionyears
  # GET /sessionyears.json
  def index
    @sessionyears = Sessionyear.all
  end

  # GET /sessionyears/1
  # GET /sessionyears/1.json
  def show
  end

  # GET /sessionyears/new
  def new
    @sessionyear = Sessionyear.new
  end

  # GET /sessionyears/1/edit
  def edit
  end

  # POST /sessionyears
  # POST /sessionyears.json
  def create
    @sessionyear = Sessionyear.new(sessionyear_params)

    respond_to do |format|
      if @sessionyear.save
        format.html { redirect_to @sessionyear, notice: 'Sessionyear was successfully created.' }
        format.json { render :show, status: :created, location: @sessionyear }
      else
        format.html { render :new }
        format.json { render json: @sessionyear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessionyears/1
  # PATCH/PUT /sessionyears/1.json
  def update
    respond_to do |format|
      if @sessionyear.update(sessionyear_params)
        format.html { redirect_to @sessionyear, notice: 'Sessionyear was successfully updated.' }
        format.json { render :show, status: :ok, location: @sessionyear }
      else
        format.html { render :edit }
        format.json { render json: @sessionyear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessionyears/1
  # DELETE /sessionyears/1.json
  def destroy
    @sessionyear.destroy
    respond_to do |format|
      format.html { redirect_to sessionyears_url, notice: 'Sessionyear was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sessionyear
      @sessionyear = Sessionyear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sessionyear_params
      params.fetch(:sessionyear, {}).permit(:start_date, :end_date, :theme)
    end
end
