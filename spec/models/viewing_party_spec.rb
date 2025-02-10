require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:host_id) }
  end

  describe "relationships" do
    it { should have_many :viewing_party_users }
    it { should have_many(:users).through(:viewing_party_users)}
  end

  describe "behaviors" do
    before(:each) do
      @host = User.create!(name: "Bobby", username: "bobbee123", password: "ghjtjtkekek33874", password_confirmation: "ghjtjtkekek33874")
      @guest1 = User.create!(name: "Carry", username: "carbear15", password: "480jr4njkdfsnjk", password_confirmation: "480jr4njkdfsnjk")
      @guest2 = User.create!(name: "Donny", username: "donn562", password: "fhdjsk8348uy839839",  password_confirmation: "fhdjsk8348uy839839")
    end
    describe "#invite_guests" do
      it "should add guests to the viewParty's users" do
        viewing_party = ViewingParty.create!(name: "Turing Cohort Movie Night!",
                                            start_time: "2025-03-17 18:00:00",
                                            end_time: "2025-03-17 20:30:00",
                                            movie_id: 278,
                                            movie_title: "The Shawshank Redemption",
                                            host_id: @host[:id])
        guests_to_invite = { invitees: [@guest1.id, @guest2.id] }
        
        expect(viewing_party.users.count).to eq(0)

        viewing_party.invite_guests(guests_to_invite)

        expect(viewing_party.users.count).to eq(guests_to_invite[:invitees].count)
      end
    end
  end
end