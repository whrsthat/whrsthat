json.array!(@users) do |user|
  json.extract! user, :id, :phone, :fname, :lname_initial, :email, :prof_img_url
  json.url user_url(user, format: :json)
end
