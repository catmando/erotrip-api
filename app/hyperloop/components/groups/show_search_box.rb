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
    form.search do
      div.search_header do
        div.info.f_s_16 do
          span.text_primary { params['users_count'] }
          span.text_gray {' użytkowników'}
        end

        div.search_input do
          a.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.more.mr_3(class: "#{'active' if state.opened}") do
            i.ero_search
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

      div.row.search_body(class: "#{'open' if state.opened}") do
        div.col_12.search_header_mobile.d_md_none do
          span {'Wyszukaj'}
          button.btn.btn_outline_primary.btn_outline_gray.icon_only.rotated_45deg(type: "button") do
            i.ero_cross
          end
        end

        div.col_12.col_xl_6.search_preferences do
          div.row do
            div.col_12.col_md_6 do
              div.form_group do
                label {'Szukam'}
                MultiSelect(placeholder: "Szukam", name: 'gender[]', selection: state.search_params['gender']).on :change do |e|
                  mutate.search_params['gender'] = e.to_n
                  propagate_change
                end
                # selection: params[:gender] || []
                # , options: [{value: 'm', label: 'Mężczyzn'}, {value: 'f', label: 'Kobiet'}]
              end
            end
            div.col_12.col_md_6 do
              div.form_group do
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

        div.col_12.col_xl_6.location do
          div.form_group do
            label {'Gdzie'}
            Select(placeholder: "Gdzie", name: 'where', selection: state.search_params['where']).on :change do |e|
              mutate.search_params['where'] = e.to_n
              propagate_change
            end
            # selection: params[:where] || ''
            # , options: [{value: 1, label: 'Jeden'}, {value: 2, label: 'Dwa'}]
          end
        end

        div.col_12.col_xl_6.age do
          div.form_group do
            label {'Wiek'}
            SliderRange(name: 'age[]', selection: state.search_params['age']).on :change do |e|
              mutate.search_params['age'] = e.to_n
              propagate_change
            end
            # selection: params[:age] || [20, 30]
          end
        end

        div.col_12.col_xl_6.location_range do
          div.form_group do
            label {'Cała polska'}
            Slider(name: 'distance', selection: state.search_params['distance']).on :change do |e|
              mutate.search_params['distance'] = e.to_n
              propagate_change
            end
            # selection: params[:distance] || 30
          end
        end

        div.col_12.col_xl_6.height do
          div.row do
            div.col_12.col_md_6 do
              div.form_group do
                label {'Wzrost'}
                MultiSelect(placeholder: "Wzrost", name: 'height[]', selection: state.search_params['height']).on :change do |e|
                  mutate.search_params['height'] = e.to_n
                  propagate_change
                end
                # selection: params[:height] || []
              end
            end

            div.col_12.col_md_6 do
              div.form_group do
                label {'Sylwetka'}
                MultiSelect(placeholder: "Sylwetka", name: 'look[]', selection: state.search_params['look']).on :change do |e|
                  mutate.search_params['look'] = e.to_n
                  propagate_change
                end
                # selection: params[:look] || []
              end
            end

            div.col_12 do
              div.form_group do
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

        div.col_12.col_xl_6.options do
          fieldset.form_group do
            legend {'Tylko'}
            div.form_check.form_check_inline do
              label.form_check_label do
                input.form_check_input(type: "checkbox").on :change do |e|
                  mutate.search_params['verified'] = e.target.checked
                  propagate_change
                end
                span
                'Zweryfikowani'
              end
            end

            div.form_check.form_check_inline do
              label.form_check_label do
                input.form_check_input(type: "checkbox").on :change do |e|
                  mutate.search_params['with_photos'] = e.target.checked
                  propagate_change
                end
                span
                'Ze zdjęciami'
              end
            end
          end

          fieldset.form_group do
            legend {'Dodatkowo'}
            div.form_check.form_check_inline do
              label.form_check_label do
                input.form_check_input(type: "checkbox").on :change do |e|
                  mutate.search_params['smoking'] = e.target.checked
                  propagate_change
                end
                span
                'Papierosy'
              end
            end

            div.form_check.form_check_inline do
              label.form_check_label do
                input.form_check_input(type: "checkbox").on :change do |e|
                  mutate.search_params['drinking'] = e.target.checked
                  propagate_change
                end
                span
                'Alkohol'
              end
            end
          end
        end

        div.col.search_footer do
          button.btn.btn_secondary.mr_4(type: "submit") {'Pokaż'}
          button.btn.btn_outline_primary.btn_outline_gray.text_gray(type: "button") {'Anuluj'}
        end
      end
    end
  end
end