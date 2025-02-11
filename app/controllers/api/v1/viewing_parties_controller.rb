class Api::V1::ViewingPartiesController < ApplicationController
  def create
    invitees = params.permit(invitees: [])
    if ViewingParty.valid_movie_params?(viewing_party_params)
      if ViewingParty.valid_time_and_duration?(viewing_party_params)
        viewing_party = ViewingParty.create!(viewing_party_params)
        viewing_party.invite_guests(invitees)
        render json: ViewingPartySerializer.format_viewing_party(viewing_party), status: :created
      else
        render json: ErrorSerializer.format_error(ErrorMessage.new("Request failed: viewing party start time and end time must be valid", 400)), status: :bad_request
      end
    else
      viewing_party = ViewingParty.new(viewing_party_params)
      viewing_party.errors.add(:base, "Movie can't be blank, Movie title can't be blank")
      raise ActiveRecord::RecordInvalid.new(viewing_party)
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