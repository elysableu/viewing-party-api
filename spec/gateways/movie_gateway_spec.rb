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
        'Authorization'=>Rails.application.credentials.themoviedb[:key],
        'User-Agent'=>'Faraday v2.10.1'
          }).
        to_return(status: 200, body: json_response)

    json_response = MovieGateway.fetch_top_rated_movies(20)

    json_response.each do |movie|
      expect(movie).to have_key :id
      expect(movie).to have_key :title
      expect(movie).to have_key :vote_average
    end
  end
end