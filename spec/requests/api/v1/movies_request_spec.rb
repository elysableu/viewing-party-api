require "rails_helper"

RSpec.describe "Movies Endpoint" do
  describe "happy path" do
    it "can retrieve top-rated movies for themoviedb api" do
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

      get "/api/v1/movies/top_rated?total_results=20"
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data].count).to eq(20)

      json[:data].each do |movie|
        expect(movie).to have_key(:id)
        expect(movie[:type]).to eq("movie")
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end
    end
  end
end