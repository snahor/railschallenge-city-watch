class EmergenciesController < ApplicationController
  before_action :set_emergency, only: [:show, :update, :destroy]

  # GET /emergencies
  # GET /emergencies.json
  def index
    @emergencies = Emergency.all
  end

  # GET /emergencies/1
  # GET /emergencies/1.json
  def show
  end

  # GET /emergencies/new
  def new
    @emergency = Emergency.new
  end

  # POST /emergencies
  # POST /emergencies.json
  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save(emergency_params)
      render :show, status: :created, location: @emergency
    else
      render json: { message: @emergency.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /emergencies/1
  # PATCH/PUT /emergencies/1.json
  def update
    if @emergency.update(emergency_params)
      render :show, status: :ok, location: @emergency
    else
      render json: { message: @emergency.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /emergencies/1
  # DELETE /emergencies/1.json
  def destroy
    @emergency.destroy
    respond_to do |format|
      format.html { redirect_to emergencies_url, notice: 'Emergency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_emergency
    @emergency = Emergency.find_by!(code: params[:code])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def emergency_params
    allowed_parameters = [:fire_severity, :police_severity, :medical_severity, :full_response]
    if !@emergency || @emergency.new_record?
      allowed_parameters << :code
    else
      allowed_parameters << :resolved_at
    end
    params.require(:emergency).permit(*allowed_parameters)
  end
end
