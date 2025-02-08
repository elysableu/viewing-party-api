class AddForeignKeysToViewingPartyUsers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :viewing_party_users, :viewing_parties, column: :viewing_party_id
    add_foreign_key :viewing_party_users, :users, column: :user_id
  end
end
