class Api::V1::ViewingPartiesController < ApplicationController
  def create
    viewing_party = ViewingParty.create!(viewing_party_params)
    viewing_party.invite_guests(viewing_party_invitees)
    render json: ViewingPartySerializer.format_viewing_party(viewing_party, viewing_party_invitees), status: :created
  end

  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host_id)
  end

  def viewing_party_invitees
    params.permit(invitees: [])
  end
end