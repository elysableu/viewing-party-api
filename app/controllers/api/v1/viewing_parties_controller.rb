class Api::V1::ViewingPartiesController < ApplicationController
  def create
    invitees = params.permit(invitees: [])
    viewing_party = ViewingParty.create!(viewing_party_params)
    viewing_party.invite_guests(invitees)
    render json: ViewingPartySerializer.format_viewing_party(viewing_party, invitees), status: :created
  end

  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host_id)
  end
end