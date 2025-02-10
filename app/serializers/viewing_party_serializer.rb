class ViewingPartySerializer
  def self.format_list_of_viewing_parties(parties)
    { data: 
    parties.map do |party|
      invitees = party.users
      formatter(party, invitees)
    end
  }
  
  end

  def self.format_viewing_party(party)
    invitees = party.users
    { data:
        formatter(party, invitees)
    }
  end

  def self.formatter(party, invitees)
    { id: party[:id].to_s,
      type: "viewing_party",
      attributes: {
        name: party[:name],
        start_time: party[:start_time],
        end_time: party[:end_time],
        movie_id: party[:movie_id],
        movie_title: party[:movie_title],
        invitees: [
          invitees.map do |invitee|
            invitees_formatter(invitee)
          end
        ]
      }}
  end

  def self.invitees_formatter(invitee)
    {
      id: invitee[:id],
      name: invitee[:name],
      username: invitee[:username]
    }
  end
end