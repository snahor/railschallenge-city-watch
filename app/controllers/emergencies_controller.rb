class EmergenciesController < ApplicationController
  before_action :set_emergency, only: [:show, :update, :destroy]

  def index
    @emergencies = Emergency.all
  end

  def show
  end

  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save(emergency_params)
      render :show, status: :created, location: @emergency
    else
      render json: { message: @emergency.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @emergency.update(emergency_params)
      render :show, status: :ok, location: @emergency
    else
      render json: { message: @emergency.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @emergency.destroy
    head :no_content
  end

  private

  def set_emergency
    @emergency = Emergency.find_by!(code: params[:code])
  end

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
