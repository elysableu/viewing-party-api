class MovieGateway
  def self.fetch_top_rated_movies()
      conn = connect()

      response = conn.get("/3/movie/top_rated", { page: 1 })

      json = JSON.parse(response.body, symbolize_names: true)

      json[:results]
  end

  def self.fetch_movies_by_search(query)
    conn = connect()

    response = conn.get("/3/search/movie", { query: query, page: 1 } )

    json = JSON.parse(response.body, symbolize_names: true)

    json[:results]
  end

  def self.fetch_movie_details(query)
    conn = connect()
    details_response = conn.get("/3/movie/#{query.to_i}")
    credits_response = conn.get("/3/movie/#{query.to_i}/credits")
    reviews_response = conn.get("/3/movie/#{query.to_i}/reviews")

    details = JSON.parse(details_response.body)
    credits = JSON.parse(credits_response.body)
    reviews = JSON.parse(reviews_response.body)

    target_movie = Movie.new(details, credits, reviews)
   
    return target_movie
  end

  private

  def self.connect
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.themoviedb[:token]}"
    end

    return conn
  end
end