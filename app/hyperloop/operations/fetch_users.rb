class FetchUsers < Hyperloop::ServerOp
  param :page, default: 1
  param :per_page, default: 25
  param :terms, default: {}
  param :acting_user, default: nil, nils: true

  step do
    search_terms = params.terms
    search_terms['limit'] = params.per_page
    search_terms['offset'] = (params.page - 1) * params.per_page
    # count = User.select('count(*) as birth_year').ransack(params.terms).result.first.birth_year
    count = User.total_elements(search_terms)
    users = User.filter(search_terms)
    # .offset((params.page - 1) * params.per_page).limit(params.per_page)
    { count: count, users: users }
  end
end