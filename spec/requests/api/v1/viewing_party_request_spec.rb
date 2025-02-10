require "rails_helper"

RSpec.describe "ViewingPartys API", type: :request do
  describe "create ViewingParty endpoint" do
    it "can create a viewingParty" do

      host = User.create!(name: "Bobby", username: "bobbee123", password: "ghjtjtkekek33874", password_confirmation: "ghjtjtkekek33874")
      guest1 = User.create!(name: "Carry", username: "carbear15", password: "480jr4njkdfsnjk", password_confirmation: "480jr4njkdfsnjk")
      guest2 = User.create!(name: "Donny", username: "donn562", password: "fhdjsk8348uy839839",  password_confirmation: "fhdjsk8348uy839839")

      param = {
        name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 20:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        host_id: host.id,
        invitees: [ host.id, guest1.id, guest2.id ]
      }

      post "/api/v1/viewing_parties", params: params, as: :json
      
      created_viewing_party = ViewingParty.last

      expect(response).to be_successful
      expect(created_viewing_party.name).to eq(params[:name])
      expect(created_viewing_party.start_time).to eq(params[:start_time])
      expect(created_viewing_party.end_time).to eq(params[:end_time])
      expect(created_viewing_party.movie_id).to eq(params[:movie_id])
      expect(created_viewing_party.host_id).to eq(params[:host_id])
      expect(created_viewing_party.users.count).to eq(params[:invitees].count)
    end
  end
end