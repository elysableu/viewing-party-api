class MovieGateway 
  def self.fetch_top_rated_movies(num_results)
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.themoviedb[:key]
    end

    response = conn.get("/3/movie/top_rated", { total_results: num_results })

    json = JSON.parse(response.body, symbolize_names: true)

    json[:results]
  end
end