class GroupsIndexSearchBox < Hyperloop::Component
  state search_params: {
    kinds_cont:           [],
    # kinds_cont_opposite:[],
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
    form.search do
      div.search_header do
        div.info.f_s_16 do
          span.text_primary { params.groups_count.to_s }
          span.text_gray {' grup'}
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
          a.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.more.ml_3 do
            i.ero_cross
          end
          .on :click do |e|
            add_group
          end
        end
      end

      div.row.search_body.search_body_small(class: "#{'open' if state.opened}") do
        div.col_12.search_header_mobile.d_md_none do
          span {'Wyszukaj'}
          button.btn.btn_outline_primary.btn_outline_gray.icon_only.rotated_45deg(type: "button") do
            i.ero_cross
          end
        end

        div.col_12.search_preferences do
          div.row do
            div.col_12.col_md_6 do
              div.form_group do
                label {'Szukam'}
                MultiSelect(placeholder: "Szukam", name: 'kinds_cont[]', selection: state.search_params['kinds_cont']).on :change do |e|
                  mutate.search_params['kinds_cont'] = e.to_n
                end
              end
            end
            div.col_12.col_md_6 do
              div.form_group do
                label {'Nazwa'}
                input.form_control(placeholder: "Nazwa", name: 'name_cont').on :key_up do |e|
                  mutate.search_params['name_cont'] = e.target.value
                end
              end
            end
          end
        end

        div.col_12.search_footer(style: {paddingTop: '23px'}) do
          button.btn.btn_secondary.mr_4(type: "submit") {'Pokaż'}
          button.btn.btn_outline_primary.btn_outline_gray.text_gray(type: "button") do
            'Anuluj'
          end.on :click do
            mutate.search_params({
              kinds_cont:             [],
              # kinds_cont_opposite:  [],
              name_cont:              '',
              # age:                  [20, 30],
              # distance:             30,
              # height:               [],
              # look:                 [],
              # interests:            [],
              sorts:                  'latest'
            })
            propagate_change
            mutate.opened false
          end
        end
      end
    end.on :submit do |e|
      e.prevent_default
      propagate_change
      mutate.opened false
    end
  end
end