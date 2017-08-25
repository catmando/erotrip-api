class GroupsShowSearchBox < Hyperloop::Component
  state search_params: {
    gender:           [],
    gender_opposite:  [],
    where:            '',
    age:              [20, 30],
    distance:         30,
    height:           [],
    look:             [],
    interests:        [],
    sorts:            'latest'
  }
  state opened: false

  param onChange: nil

  param users_count: 0

  after_mount do
    # mutate.opened false
    # mutate.search_params({
    #   gender:           [],
    #   gender_opposite:  [],
    #   where:            '',
    #   age:              [20, 30],
    #   distance:         30,
    #   height:           [],
    #   look:             [],
    #   interests:        []
    # })
  end

  def sort_options
    [
      {value: 'latest', label: 'Najnowsze'},
      {value: 'online', label: 'Teraz online'},
      {value: 'last_seen', label: 'Ostatnio byli'}
    ]
  end

  def propagate_change
    params.onChange.call(state.search_params) if params.onChange.present?
  end

  def render
    form(class: 'search') do
      div(class: 'search-header') do
        div(class: 'info f-s-16') do
          span(class: 'text-primary') { params['users_count'] }
          span(class: 'text-gray') {' użytkowników'}
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
        end
      end

      div(class: "row search-body #{'open' if state.opened}") do
        div(class: 'col-12 search-header-mobile d-md-none') do
          span {'Wyszukaj'}
          button(class: 'btn btn-outline-primary btn-outline-gray icon-only rotated-45deg', type: "button") do
            i(class: 'ero-cross')
          end
        end

        div(class: 'col-12 col-xl-6 search-preferences') do
          div(class: 'row') do
            div(class: 'col-12 col-md-6') do
              div(class: 'form-group') do
                label {'Szukam'}
                MultiSelect(placeholder: "Szukam", name: 'gender[]', selection: state.search_params['gender']).on :change do |e|
                  mutate.search_params['gender'] = e.to_n
                  propagate_change
                end
                # selection: params[:gender] || []
                # , options: [{value: 'm', label: 'Mężczyzn'}, {value: 'f', label: 'Kobiet'}]
              end
            end
            div(class: 'col-12 col-md-6') do
              div(class: 'form-group') do
                label {'Szukających'}
                MultiSelect(placeholder: "Szukających", name: 'gender_opposite[]', selection: state.search_params['gender_opposite']).on :change do |e|
                  mutate.search_params['gender_opposite'] = e.to_n
                  propagate_change
                end
                # selection: params[:gender_opposite] || []
              end
            end
          end
        end

        div(class: 'col-12 col-xl-6 location') do
          div(class: 'form-group') do
            label {'Gdzie'}
            Select(placeholder: "Gdzie", name: 'where', selection: state.search_params['where']).on :change do |e|
              mutate.search_params['where'] = e.to_n
              propagate_change
            end
            # selection: params[:where] || ''
            # , options: [{value: 1, label: 'Jeden'}, {value: 2, label: 'Dwa'}]
          end
        end

        div(class: 'col-12 col-xl-6 age') do
          div(class: 'form-group') do
            label {'Wiek'}
            SliderRange(name: 'age[]', selection: state.search_params['age']).on :change do |e|
              mutate.search_params['age'] = e.to_n
              propagate_change
            end
            # selection: params[:age] || [20, 30]
          end
        end

        div(class: 'col-12 col-xl-6 location_range') do
          div(class: 'form-group') do
            label {'Cała polska'}
            Slider(name: 'distance', selection: state.search_params['distance']).on :change do |e|
              mutate.search_params['distance'] = e.to_n
              propagate_change
            end
            # selection: params[:distance] || 30
          end
        end

        div(class: 'col-12 col-xl-6 height') do
          div(class: 'row') do
            div(class: 'col-12 col-md-6') do
              div(class: 'form-group') do
                label {'Wzrost'}
                MultiSelect(placeholder: "Wzrost", name: 'height[]', selection: state.search_params['height']).on :change do |e|
                  mutate.search_params['height'] = e.to_n
                  propagate_change
                end
                # selection: params[:height] || []
              end
            end

            div(class: 'col-12 col-md-6') do
              div(class: 'form-group') do
                label {'Sylwetka'}
                MultiSelect(placeholder: "Sylwetka", name: 'look[]', selection: state.search_params['look']).on :change do |e|
                  mutate.search_params['look'] = e.to_n
                  propagate_change
                end
                # selection: params[:look] || []
              end
            end

            div(class: 'col-12') do
              div(class: 'form-group') do
                label {'Zainteresowania'}
                MultiSelectWithLabels(placeholder: "Zainteresowania", name: 'interests[]', selection: state.search_params['interests']).on :change do |e|
                  mutate.search_params['interests'] = e.to_n
                  propagate_change
                end
                # selection: params[:interests] || []
              end
            end
          end
        end

        div(class: 'col-12 col-xl-6 options') do
          fieldset(class: 'form-group') do
            legend {'Tylko'}
            div(class: 'form-check form-check-inline') do
              label(class: 'form-check-label') do
                input(class: 'form-check-input', type: "checkbox").on :change do |e|
                  mutate.search_params['verified'] = e.target.checked
                  propagate_change
                end
                span
                'Zweryfikowani'
              end
            end

            div(class: 'form-check form-check-inline') do
              label(class: 'form-check-label') do
                input(class: 'form-check-input', type: "checkbox").on :change do |e|
                  mutate.search_params['with_photos'] = e.target.checked
                  propagate_change
                end
                span
                'Ze zdjęciami'
              end
            end
          end

          fieldset(class: 'form-group') do
            legend {'Dodatkowo'}
            div(class: 'form-check form-check-inline') do
              label(class: 'form-check-label') do
                input(class: 'form-check-input', type: "checkbox").on :change do |e|
                  mutate.search_params['smoking'] = e.target.checked
                  propagate_change
                end
                span
                'Papierosy'
              end
            end

            div(class: 'form-check form-check-inline') do
              label(class: 'form-check-label') do
                input(class: 'form-check-input', type: "checkbox").on :change do |e|
                  mutate.search_params['drinking'] = e.target.checked
                  propagate_change
                end
                span
                'Alkohol'
              end
            end
          end
        end

        div(class: 'col search-footer') do
          button(class: 'btn btn-secondary mr-4', type: "submit") {'Pokaż'}
          button(class: 'btn btn-outline-primary btn-outline-gray text-gray', type: "button") {'Anuluj'}
        end
      end
    end
  end
end