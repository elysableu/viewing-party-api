class MovieSerializer
  def self.format_movie_list(movies)
    { data:
        movies.map do |movie|
         formatter(movie)
        end
    }
  end

  def self.format_movie(movie)
    { data: formatter(movie) }
  end

  def self.formatter(movie)
    {
      id: movie[:id].to_s,
      type: "movie",
      attributes: {
        title: movie[:title],
        vote_average: movie[:vote_average]
      }
    }
  end
end