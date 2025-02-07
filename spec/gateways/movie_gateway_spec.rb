require "rails_helper"

RSpec.describe MovieGateway do
  it "should make call to theMovieDb to retrieve top rated movies" do
    # INPUT -> number of top rated movies
    # OUTPUT -> JSON response
    json_response = File.read('spec/fixtures/themoviedb_top_rated_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?total_results=20").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{Rails.application.credentials.themoviedb[:token]}",
        'User-Agent'=>'Faraday v2.10.1'
          }).
        to_return(status: 200, body: json_response)

    fetched_movies = MovieGateway.fetch_top_rated_movies(20)

    fetched_movies.each do |movie|
      expect(movie).to have_key :id
      expect(movie).to have_key :title
      expect(movie).to have_key :vote_average
    end
  end

  it "should make a call to theMovieDB to retrieve a movie based on search query" do
    json_response = File.read('spec/fixtures/themoviedb_top_rated_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=Interstellar").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{Rails.application.credentials.themoviedb[:token]}",
        'User-Agent'=>'Faraday v2.10.1'
          }).
        to_return(status: 200, body: json_response)

    fetched_movies = MovieGateway.fetch_movie_by_title("Interstellar")
    movie = fetched_movies[0]

    expect(movie).to have_key :id
    expect(movie[:id]).to eq(157336)
    expect(movie).to have_key :title
    expect(movie[:title]).to eq("Interstellar")
    expect(movie).to have_key :vote_average
    expect(movie[:vote_average]).to eq(8.4)
  end

  # it "should return an error if num_results query is greater than 20" do
  #   json_response = File.read('spec/fixtures/themoviedb_top_rated_response.json')

  #   stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?total_results=20").
  #       with(
  #         headers: {
  #       'Accept'=>'*/*',
  #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'Authorization'=>Rails.application.credentials.themoviedb[:key],
  #       'User-Agent'=>'Faraday v2.10.1'
  #         }).
  #       to_return(status: 200, body: json_response)

  #   expect{ MovieGateway.fetch_top_rated_movies(21) }.to raise_error()

    
  # end
end