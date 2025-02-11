class ViewingParty < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  validates :host_id, presence: true

  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  def invite_guests(invitee_ids)  
    invitee_ids[:invitees].each do |id|
      self.users << User.where(id: id)
    end
  end

  def self.valid_movie_params?(params)
    params[:movie_id].present? && params[:movie_title].present?
  end

  def self.valid_time_and_duration?(params)
    start_time = params[:start_time]
    end_time = params[:end_time]
    movie_id = params[:movie_id]
    
    return valid_time?(start_time, end_time) && valid_duration?(movie_id, start_time, end_time)
  end


  def self.valid_time?(start_time, end_time)
    start_time < end_time
  end

  def self.valid_duration?(movie_id, start_time, end_time)
    runtime = MovieGateway.fetch_movie_details( movie_id ).runtime
    party_duration = (Time.parse(end_time) - Time.parse(start_time)) / 60   # (duration in seconds) / 60 = duration in minutes 
    
    runtime < party_duration
  end
end