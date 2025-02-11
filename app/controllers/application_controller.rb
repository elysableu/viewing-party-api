class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerializer.format_error(ErrorMessage.new(e.message, 400)), status: :unprocessable_entity
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: ErrorSerializer.format_error(ErrorMessage.new(e.message, 400)), status: :bad_request
  end
end
