class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerializer.format_error(e.message, 400), status: :unprocessable_entity
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    if e.message.include?("Counldn't find User with 'id'=")
      head :ok
    end
  end

  rescue_from ArgumentError do |e|
    render json: ErrorSerializer.format_error(e.message, 400), status: :bad_request
  end

end
