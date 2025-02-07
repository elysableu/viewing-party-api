class Api::V1::MoviesController < ApplicationController

  def index
    if params[:request].present? && params[:request] == "top_rated"
      results = MovieGateway.fetch_top_rated_movies( params[:total_results] )
      render json: MovieSerializer.format_movie_list(results)
      
    elsif params[:request].present? && params[:request] == "search"
      results = Movie.MovieGateway.fetch_search_movies( params[:query] )
      render json: MovieSerializer.format_movie_list(results)
    end
  end
end