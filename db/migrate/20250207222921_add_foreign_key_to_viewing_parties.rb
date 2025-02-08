class AddForeignKeyToViewingParties < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :viewing_parties, :users, column: :host_id
  end
end
