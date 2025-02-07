require "rails_helper"

RSpec.describe "Movies Endpoint" do
  describe "happy path" do
    it "can retrieve top-rated movies from themoviedb api" do
      json_response = File.read('spec/fixtures/themoviedb_top_rated_response.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?page=1").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{Rails.application.credentials.themoviedb[:token]}",
          'User-Agent'=>'Faraday v2.10.1'
           }).
         to_return(status: 200, body: json_response)

      get "/api/v1/movies/top_rated?request=top_rated"
    
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data].count).to eq(20)

      json[:data].each do |movie|
        expect(movie).to have_key :id
        expect(movie[:type]).to eq("movie")
        expect(movie[:attributes]).to have_key :title
        expect(movie[:attributes]).to have_key :vote_average
      end
    end

    it "can retrieve a list of movies based on a search query from themoviedb api" do
      json_response = File.read("spec/fixtures/themoviedb_search_movie_response.json")

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=Interstellar&page=1").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{Rails.application.credentials.themoviedb[:token]}",
        'User-Agent'=>'Faraday v2.10.1'
          }).
        to_return(status: 200, body: json_response)

        get "/api/v1/movies/search?request=search&query=Interstellar"

        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].count).to eq(20)

        first_result = json[:data][0]
        
        expect(first_result).to have_key :id
        expect(first_result[:id]).to eq("157336")
        expect(first_result[:type]).to eq("movie")
        expect(first_result[:attributes]).to have_key :title
        expect(first_result[:attributes][:title]).to eq("Interstellar")
        expect(first_result[:attributes]).to have_key :vote_average
        expect(first_result[:attributes][:vote_average]).to eq(8.4)
    end
  end

  describe "sad path" do

  end
end