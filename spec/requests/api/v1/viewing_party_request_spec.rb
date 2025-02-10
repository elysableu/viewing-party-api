require "rails_helper"

RSpec.describe "ViewingPartys API", type: :request do
  before(:each) do
    @host = User.create!(name: "Bobby", username: "bobbee123", password: "ghjtjtkekek33874", password_confirmation: "ghjtjtkekek33874")
    @guest1 = User.create!(name: "Carry", username: "carbear15", password: "480jr4njkdfsnjk", password_confirmation: "480jr4njkdfsnjk")
    @guest2 = User.create!(name: "Donny", username: "donn562", password: "fhdjsk8348uy839839",  password_confirmation: "fhdjsk8348uy839839")
    
    movies = File.read('spec/fixtures/themoviedb_search_movie_response.json')
    @movie = JSON.parse(movies)['results'].first
  end

  describe "happy paths" do
    describe "create ViewingParty endpoint" do
      it "can create a viewingParty" do
        params = {
          name: "Turing Cohort Movie Night!",
          start_time: "2025-03-17 18:00:00",
          end_time: "2025-03-17 20:30:00",
          movie_id: @movie['id'],
          movie_title: @movie['title'],
          host_id: @host.id,
          invitees: [ @host.id, @guest1.id, @guest2.id ]
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

    describe "index ViewParty endpoint" do
      it "can return the list of viewingParties with invitees" do
        viewingParty = ViewingParty.create!( name: "Turing Cohort Movie Night!",
                                            start_time: "2025-03-17 18:00:00",
                                            end_time: "2025-03-17 20:30:00",
                                            movie_id: @movie['id'],
                                            movie_title: @movie['title'],
                                            host_id: @host.id)

        viewingParty.invite_guests(invitees: [ @host.id, @guest1.id, @guest2.id ])
                                      

        get "/api/v1/viewing_parties"  

        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: :true)

        expect(json[:data][0][:attributes]).to have_key(:name)
        expect(json[:data][0][:attributes]).to have_key(:start_time)
        expect(json[:data][0][:attributes]).to have_key(:end_time)
        expect(json[:data][0][:attributes]).to have_key(:movie_id)
        expect(json[:data][0][:attributes]).to have_key(:movie_title)
        expect(json[:data][0][:attributes]).to_not have_key(:host_id)
        expect(json[:data][0][:attributes]).to have_key(:invitees)
      end
    end

    describe "ViewingParty invitations endpoint" do
      it "can invite users to existing viewingParty" do
        viewingParty = ViewingParty.create!( name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 20:30:00",
        movie_id: @movie['id'],
        movie_title: @movie['title'],
        host_id: @host.id,
        invitees: [ @host.id, @guest1.id, @guest2.id ])
      end
    end

    
  end

  describe "sad paths" do
    it "returns an error when request is missing required attributes of viewing party" do
      params = {
        name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 20:30:00",
        host_id: @host.id,
        invitees: [ @host.id, @guest1.id, @guest2.id ]
      }

      post "/api/v1/viewing_parties", params: params, as: :json
      json = JSON.parse(response.body, symbolize_names: :true)
      
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json[:message]).to eq("Validation failed: Movie can't be blank, Movie title can't be blank")
      expect(json[:status]).to eq(400)
    end

    xit "returns an error when party duration is less than movie runtime" do
      WebMock.allow_net_connect!

      params = {
        name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 18:30:00",
        movie_id: @movie['id'],
        movie_title: @movie['title'],
        host_id: @host.id,
        invitees: [ @host.id, @guest1.id, @guest2.id ]
      }

      post "/api/v1/viewing_parties", params: params, as: :json
      json = JSON.parse(reponse.body, symbolize_names: :true)

      expect(response).too have_http_status(:bad_request)
      expect(json[:message]).to eq("Request failed: party duration must be longer than movie runtime")
      expect(json[:status]).to eq(400)

      WebMock.disable_net_connect!
    end

    it "returns an error when end time is before start time" do
      params = {
        name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 16:30:00",
        movie_id: @movie['id'],
        movie_title: @movie['title'],
        host_id: @host.id,
        invitees: [ @host.id, @guest1.id, @guest2.id ]
      }

      post "/api/v1/viewing_parties", params: params, as: :json
      json = JSON.parse(response.body, symbolize_names: :true)

      expect(response).to have_http_status(:bad_request)
      expect(json[:message]).to eq("Request failed: party start time must be before it's end time")
      expect(json[:status]).to eq(400)
    end

    it "only invites users with valid IDs" do
      test_guest_id = 99999

      params = {
        name: "Turing Cohort Movie Night!",
        start_time: "2025-03-17 18:00:00",
        end_time: "2025-03-17 18:30:00",
        movie_id: @movie['id'],
        movie_title: @movie['title'],
        host_id: @host.id,
        invitees: [ @host.id, @guest1.id, @guest2.id, test_guest_id ]
      }

      post "/api/v1/viewing_parties", params: params, as: :json
    
      created_viewing_party = ViewingParty.last

      expect(response).to be_successful
      expect(created_viewing_party.users.count).to eq(params[:invitees].count - 1)
    end
  end
end