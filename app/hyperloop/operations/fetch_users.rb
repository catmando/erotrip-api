class FetchUsers < Hyperloop::ServerOp
  param :page, default: 1
  param :per_page, default: 25

  # fail do |e|
  #   puts e
  # end
  failed do |e|
    puts e.inspect
  end
  step do
    puts 'FETCHING USERS'
    puts params.per_page
    puts params.page
    puts (params.page - 1) * params.per_page
    User.fetch_collection(params.per_page, (params.page - 1) * params.per_page)
     # order(created_at: :desc).limit(params.per_page).offset((params.page - 1) * params.per_page)
  end
  failed do |e|
    puts "FAILED!!!"
    puts e.inspect
  end
end