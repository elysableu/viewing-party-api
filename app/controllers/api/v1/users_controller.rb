class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  def index
    render json: UserSerializer.format_user_list(User.all)
  end

  def show 
    user_id = params[:user]
    if User.valid?(user_id)
      render json UserSerializer.format_user_profile(user_id)
    else  
      render json: ErrorSerializer.format_error(ErrorMessage.new("Invalid User ID", 404)), status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:name, :username, :password, :password_confirmation)
  end
end