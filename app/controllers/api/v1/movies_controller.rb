class Api::V1::MoviesController < ApplicationController

  def index
    if params[:request].present? && params[:request] == "top_rated"
      results = MovieGateway.fetch_top_rated_movies()
      render json: MovieSerializer.format_movie_list(results)

    elsif params[:request].present? && params[:request] == "search"
      results = MovieGateway.fetch_movies_by_search( params[:query] )
      render json: MovieSerializer.format_movie_list(results)
    end
  end
end