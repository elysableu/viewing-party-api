class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: { require: true }
  has_secure_password
  has_secure_token :api_key

  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  private

  def self.valid?(user_id)
    User.find(user_id).present?
  end
end