require "rails_helper"

RSpec.describe "ViewingPartys API", type: :request do
  describe "create ViewingParty endpoint" do
    it "can create a viewingParty" do

      host = User.create!(name: "Bobby", username: "bobbee123", password: "ghjtjtkekek33874")
      guest1 = User.create!(name: "Carry", username: "carbear15", password: "480jr4njkdfsnjk")
      guest2 = User.create!(name: "Bobby", username: "bobbee12", password: "ghjtjtkekek33874")


      params = {
        name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 20:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [guest1[:id], guest2[:id]],
        host_id: host[:id]
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/view_parties", headers: headers, params: JSON.generate(viewing_party: params)
      
      created_viewing_party = ViewingParty.last

      expect(response).to be_successful
      expect(created_viewing_party.name).to eq(params[:name])
      expect(created_viewing_party.start_time).to eq(params[:start_time])
      expect(created_viewing_party.end_time).to eq(params[:end_time])
      expect(created_viewing_party.movie_id).to eq(params[:movie_id])
      expect(created_viewing_party.invitees).to eq(params[:invitees])
      expect(created_viewing_party.host_id).to eq(params[:host_id])
    end
  end
end