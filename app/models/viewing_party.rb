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

  def self.valid?(params)
    start_time = params[:start_time]
    end_time = params[:end_time]
    
    return valid_time?(start_time, end_time)
  end


  def self.valid_time?(start_time, end_time)
    start_time < end_time
  end

  # def self.valid_duration?(movie_title, start_time, end_time)
  #   result = MovieGateway.fetch_movies_by_search( movie_title )[0]
  #   binding.pry
  # end

  
end