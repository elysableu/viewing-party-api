class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerializer.format_error(ErrorMessage.new(e.message, 400)), status: :unprocessable_entity
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    if e.message.include?("Counldn't find User with 'id'=")
      head :ok
    end
  end
end
