require "rails_helper"

RSpec.describe "Movies Endpoint" do
  describe "happy path" do
    it "can retrieve top-rated movies for themoviedb api" do
      get "/api/v1/movies"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)[0]

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq("movie")
      expect(json[:data][:attributes]).to have_key(:poster_path)
      expect(json[:data][:attributes]).to have_key(:adult)
      expect(json[:data][:attributes]).to have_key(:overview)
      expect(json[:data][:attributes]).to have_key(:release_date)
      expect(json[:data][:attributes]).to have_key(:genre_ids)
      expect(json[:data][:attributes]).to have_key(:id)
      expect(json[:data][:attributes]).to have_key(:orignal_title)
      expect(json[:data][:attributes]).to have_key(:original_language)
      expect(json[:data][:attributes]).to have_key(:title)
      expect(json[:data][:attributes]).to have_key(:backdrop_path)
      expect(json[:data][:attributes]).to have_key(:popularity)
      expect(json[:data][:attributes]).to have_key(:vote_count)
      expect(json[:data][:attributes]).to have_key(:video)
      expect(json[:data][:attributes]).to have_key(:vote_average)
    end
  end
end