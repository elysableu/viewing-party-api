class MovieSerializer
  def self.format_movie_list(movies)
    { data:
        movies.map do |movie|
         formatter(movie)
        end
    }
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

  def self.format_movie_details(movie)

    { data: {
        id: movie.id.to_s,
        type: "movie",
        attributes: {
          title: movie.title,
          release_year: movie.release_year.to_i,
          vote_average: movie.vote_average,
          runtime: movie.runtime,
          genres: movie.genres,
          summary: movie.summary,
          cast: movie.cast,
          total_reviews: movie.total_reviews,
          reviews: movie.reviews
        } 
      }
    }
  end
end