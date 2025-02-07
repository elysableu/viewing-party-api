class Api::V1::MoviesController < ApplicationController

  def index
    # if params[:total_results].present?
      results = MovieGateway.fetch_top_rated_movies( params[:total_results])
      render json: MovieSerializer.format_movie_list(results)
    # elsif params[:]
      
    # end
  end
end