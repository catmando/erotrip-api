class FetchResources < Hyperloop::ServerOp
  param :page, default: 1
  param :per_page, default: 25
  param :terms, default: {}
  param :resource_type
  param :acting_user, default: nil, nils: true

  step do
    search_terms = params.terms
    search_terms['limit'] = params.per_page
    search_terms['offset'] = (params.page - 1) * params.per_page
    count = params.resource_type.classify.constantize.total_elements(search_terms)
    resources = params.resource_type.classify.constantize.filter(search_terms)
    { count: count, resources: resources }
  end
end