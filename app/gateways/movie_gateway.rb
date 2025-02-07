class MovieGateway
  def self.fetch_top_rated_movies(num_results)
    # if num_results <= 20 
      conn = connect()

      response = conn.get("/3/movie/top_rated", { total_results: num_results })

      json = JSON.parse(response.body, symbolize_names: true)

      json[:results]
    # end
  end

  private

  def self.connect
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.themoviedb[:token]}"
    end

    return conn
  end
end