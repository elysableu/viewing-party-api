class Api::V1::ViewingPartiesController < ApplicationController
  def create
    invitees = params.permit(invitees: [])
    if ViewingParty.valid?(viewing_party_params)
      viewing_party = ViewingParty.create!(viewing_party_params)
      viewing_party.invite_guests(invitees)
      render json: ViewingPartySerializer.format_viewing_party(viewing_party), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new("Request failed: party start time must be before it's end time", 400)), status: :bad_request
    end
  end

  def index
    render json: ViewingPartySerializer.format_list_of_viewing_parties(ViewingParty.all)
  end

  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host_id)
  end
end