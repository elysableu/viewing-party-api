require "rails_helper"

RSpec.describe "ViewingPartys API", type: :request do
  it { should have_many :viewing_party_users }
  it { should have_many(:user).through(:viewing_party_users)}

  describe "create ViewingParty endpoint" do
    it "can create a viewingParty" do

    end
  end
end