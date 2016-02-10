json.array!(@invitees) do |invitee|
  json.extract! invitee, :id, :attending
  json.url invitee_url(invitee, format: :json)
end
