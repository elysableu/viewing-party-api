class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerializer.format_error(e.message, 400), status: :unprocessable_entity
  end
    
end
