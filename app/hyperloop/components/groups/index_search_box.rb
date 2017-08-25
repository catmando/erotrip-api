class GroupsIndexSearchBox < Hyperloop::Component
  state search_params: {
    for_kinds:           [],
    # for_kinds_opposite:[],
    name_cont:            '',
    # age:                [20, 30],
    # distance:           30,
    # height:             [],
    # look:               [],
    # interests:          [],
    sorts:                'latest'
  }
  state opened: false

  param onChange: nil

  param groups_count: 0

  def sort_options
    [
      {value: 'latest', label: 'Najnowsze'},
      {value: 'online', label: 'Teraz online'},
      {value: 'last_seen', label: 'Ostatnio byli'}
    ]
  end

  def add_group
    RootStore.open_modal('groups_new')
  end

  def propagate_change
    params.onChange.call(state.search_params) if params.onChange.present?
  end

  def render
    form(class: 'search') do
      div(class: 'search-header') do
        div(class: 'info f-s-16') do
          span(class: 'text-primary') { params.groups_count.to_s }
          span(class: 'text-gray') {' grup'}
        end

        div(class: 'search-input') do
          a(class: "btn btn-outline-primary btn-outline-gray icon-only with-label more mr-3 #{'active' if state.opened}") do
            i(class: 'ero-search')
          end
          .on :click do |e|
            mutate.opened !state.opened
          end
          Select(name: 'sorts', placeholder: 'Sortuj', options: sort_options, selection: state.search_params['sorts']).on :change do |e|
            mutate.search_params['sorts'] = e.to_n
            propagate_change
          end
          a(class: 'btn btn-outline-primary btn-outline-gray icon-only with-label more ml-3') do
            i(class: 'ero-cross')
          end
          .on :click do |e|
            add_group
          end
        end
      end

      div(class: "row search-body search-body-small #{'open' if state.opened}") do
        div(class: 'col-12 search-header-mobile d-md-none') do
          span {'Wyszukaj'}
          button(class: 'btn btn-outline-primary btn-outline-gray icon-only rotated-45deg', type: "button") do
            i(class: 'ero-cross')
          end
        end

        div(class: 'col-12 search-preferences') do
          div(class: 'row') do
            div(class: 'col-12 col-md-6') do
              div(class: 'form-group') do
                label {'Szukam'}
                MultiSelect(placeholder: "Szukam", name: 'for_kinds[]', selection: state.search_params['for_kinds'], options: Commons.account_kinds).on :change do |e|
                  mutate.search_params['for_kinds'] = e.to_n
                end
              end
            end
            div(class: 'col-12 col-md-6') do
              div(class: 'form-group') do
                label {'Nazwa'}
                input(class: 'form-control', placeholder: "Nazwa", name: 'name_cont').on :key_up do |e|
                  mutate.search_params['name_cont'] = e.target.value
                end
              end
            end
          end
        end

        div(class: 'col-12 search-footer', style: {paddingTop: '23px'}) do
          button(class: 'btn btn-secondary mr-4', type: "submit") {'Pokaż'}
          button(class: 'btn btn-outline-primary btn-outline-gray text-gray', type: "button") do
            'Anuluj'
          end.on :click do
            mutate.search_params({
              for_kinds:             [],
              # for_kinds_opposite:  [],
              name_cont:              '',
              # age:                  [20, 30],
              # distance:             30,
              # height:               [],
              # look:                 [],
              # interests:            [],
              sorts:                  'latest'
            })
            mutate.opened false
            propagate_change
          end
        end
      end
    end.on :submit do |e|
      e.prevent_default
      mutate.opened false
      propagate_change
    end
  end
end