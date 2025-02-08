class CreateViewingPartyUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :viewing_party_users do |t|
      t.integer :viewing_party_id
      t.integer :user_id

      t.timestamps
    end
  end
end
