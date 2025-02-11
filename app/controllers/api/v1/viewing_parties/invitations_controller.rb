class Api::V1::ViewingParties::InvitationsController < ApplicationController
  def create
    
    viewing_party = find_party
    viewing_party.invite_guests(new_invitee)
    render json: ViewingPartySerializer.format_viewing_party(viewing_party), status: :created
  end

  private

  def find_party
    ViewingParty.find(params[:viewingParty])
  end

  def new_invitee
    {invitees: [params[:invitee]]}
  end
end