class Movie

  attr_reader :id, 
              :title, 
              :release_year, 
              :vote_average, 
              :runtime, 
              :genres, 
              :summary, 
              :cast, 
              :total_reviews, 
              :reviews

  def initialize(details, credits, reviews)
    @id = details["id"]
    @title = details["title"]
    @release_year = details["release_date"][0..3]
    @vote_average = details["vote_average"]
    @runtime = details["runtime"]
    @genres = format_genre(details["genres"])
    @summary = details["overview"]
    @cast = limit_cast(credits["cast"])
    @total_reviews = reviews["total_results"]
    @reviews = limit_reviews(reviews["results"])
  end

  private

  def format_genre(genres)
    genres.map { |genre|
      genre["name"]
    }
  end

  def limit_reviews(all_reviews)
    if all_reviews.nil?
      return []
    end

    all_reviews.first(5).map { |review| 
      {
        author: review["author"],
        content: review["content"]
      }
    }
  end

  def limit_cast(all_cast)
    if all_cast.nil?
      return []
    end

    all_cast.first(10).map { |cast|
      {
        actor: cast["name"],
        character: cast["character"]
      }
    }
  end


end