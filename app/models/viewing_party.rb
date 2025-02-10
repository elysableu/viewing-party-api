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
end