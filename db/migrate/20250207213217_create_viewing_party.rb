class CreateViewingParty < ActiveRecord::Migration[7.1]
  def change
    create_table :viewing_parties do |t|
      t.string :name
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :movie_id
      t.string :movie_title
      t.integer :host_id
      t.timestamps
    end
  end
end
