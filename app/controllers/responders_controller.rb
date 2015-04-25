class RespondersController < ApplicationController
  before_action :set_responder, only: [:show, :edit, :update, :destroy]

  def index
    if params[:show] == 'capacity'
      render json: { capacity: Responder.capacity_summary }
    else
      @responders = Responder.eager_load(:emergency).all
    end
  end

  def show
  end

  def create
    @responder = Responder.new(responder_params)

    if @responder.save
      render :show, status: :created, location: @responder
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @responder.update(responder_params)
      render :show, status: :ok, location: @responder
    else
      render json: @responder.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @responder.destroy
    head :no_content
  end

  private

  def set_responder
    @responder = Responder.eager_load(:emergency).find_by!(name: params[:name])
  end

  def responder_params
    if !@responder || @responder.new_record?
      allowed_parameters = [:name, :capacity, :type]
    else
      allowed_parameters = [:on_duty]
    end
    params.require(:responder).permit(*allowed_parameters)
  end
end
