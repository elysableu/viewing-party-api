class ViewingPartySerializer
  def self.format_list_of_viewing_parties(parties, invitees)
    { data: 
    parties.map do |party|
      formatter(party, invitees)
    end
  }
  
  end

  def self.format_viewing_party(party, invitees)
    { data:
        formatter(party, invitees)
    }
  end

  def self.formatter(party, invitee_ids)
    { id: party[:id].to_s,
      type: "viewing_party",
      attributes: {
        name: party[:name],
        start_time: party[:start_time],
        end_time: party[:end_time],
        movie_id: party[:movie_id],
        movie_title: party[:movie_title],
        invitees: [
          invitee_ids[:invitees].each do |id|
            invitees_formatter(id)
          end
        ]
      }}
  end

  def self.invitees_formatter(invitee_id)
    invitee = User.find(invitee_id)
    {
      id: invitee[:id],
      name: invitee[:name],
      username: invitee[:username]
    }
  end
end