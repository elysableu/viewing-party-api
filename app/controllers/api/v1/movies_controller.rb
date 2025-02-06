class Api::V1::MoviesController < ApplicationController

  def show
    results = MovieGateway.fetch_top_rated_movies( params[:total_results])
    render json: MovieSerializer.format_movie_list(results)
  end
end