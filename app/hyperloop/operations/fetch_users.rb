class FetchUsers < Hyperloop::Operation
  param :page, default: 1
  param :per_page, default: 25

  # fail do |e|
  #   puts e
  # end
  failed do |e|
    puts 'FAILED BEFORE FETCHING'
    puts e.inspect
  end
  step do
    puts 'FETCHING USERS'
    count = User.count
    users = User.order(created_at: :desc).offset((params.page - 1) * params.per_page).limit(params.per_page)
    { count: count, users: users }
  end
end