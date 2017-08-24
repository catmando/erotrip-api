class FetchUsers < Hyperloop::ServerOp
  param :page, default: 1
  param :per_page, default: 25
  param :acting_user, default: nil, nils: true

  step do
    count = User.count
    users = User.order(created_at: :desc).offset((params.page - 1) * params.per_page).limit(params.per_page)
    { count: count, users: users }
  end
end