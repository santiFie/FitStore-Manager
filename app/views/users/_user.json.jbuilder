json.extract! user, :id, :username, :email, :phone, :role, :start_date, :created_at, :updated_at
json.url user_url(user, format: :json)
