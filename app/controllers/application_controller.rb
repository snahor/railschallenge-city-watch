class ApplicationController < ActionController::Base
  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  rescue_from ActionController::UnpermittedParameters do |exception|
    render json: { message: exception.to_s }, status: :unprocessable_entity
  end

  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { message: 'page not found' }, status: :not_found
  end
end
