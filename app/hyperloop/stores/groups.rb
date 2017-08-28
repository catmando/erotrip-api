class GroupsStore < Hyperloop::Store
  state groups: [], scope: :shared, reader: true
  state total: 0, scope: :shared, reader: true
  state current_page: 1, scope: :shared, reader: true
  state per_page: 50, scope: :shared, reader: true
  state search_params: {
    gender:           [],
    gender_opposite:  [],
    where:            '',
    age:              [20, 30],
    distance:         30,
    height:           [],
    look:             [],
    interests:        []
  }, scope: :shared, reader: true
  state blocking: false, scope: :shared, reader: true

  # def initialize
  # end

  receives SaveGroup do
    puts "RECEIVED SAVE GROUP"
    new_group = params
    fetch
    # if state.groups.include? new_group
    #   index = state.groups.index
    # else
    #   mutate.groups [state.groups, new_group].flatten.uniq
    # end
  end

  def current_page! new_item
    mutate.current_page new_item
  end

  def per_page! new_item
    mutate.per_page new_item
  end

  def search_params! new_item
    mutate.search_params new_item
  end

  def search_param! name, new_param
    mutate.search_params[name] = new_param
  end

  def fetch
    self.class.fetch
  end

  def self.fetch
    mutate.blocking true
    FetchResources.run(resource_type: 'Group', page: state.current_page, per_page: state.per_page, terms: state.search_params)
    .then do |data|
      mutate.blocking false
      mutate.total data['count']
      mutate.groups data['resources'].map{ |u| Group.new(u) }
      `setTimeout(function(){window.scrollTo(0,0)}, 50)`
    end.fail do |e|
      mutate.blocking false
      mutate.groups []
      mutate.total 0
      `toast.error('Nie udało się pobrać użytkowników.')`
    end
  end
end