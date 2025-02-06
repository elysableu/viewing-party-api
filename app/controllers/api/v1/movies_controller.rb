class Api::V1::MoviesController < ApplicationController

  def show
    num_results = params[:total_results]

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.themoviedb[:key]
    end

    response = conn.get("/3/movie/top_rated", { total_results: num_results })

    json = JSON.parse(response.body, symbolize_names: true)
    
    render json: MovieSerializer.format_movie_list(json[:results])
  end
end