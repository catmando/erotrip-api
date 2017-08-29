
class GroupsIndexSearchBox < Hyperloop::Component

  param onChange: nil
  param groups_count: 0

  state opened: false
  state search_params: {
    for_kinds:           [],
    name_cont:            '',
    sorts:                'created_at desc'
  }
  state sort_options:  [
    {value: 'created_at desc', label: 'Najnowsze'},
    {value: 'created_at asc', label: 'Najstarsze'}
  ]

  def add_group
    ModalsService.open_modal(GroupsNewModal, { size_class: 'modal-lg' })
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
          Select(name: 'sorts', placeholder: 'Sortuj', options: state.sort_options, selection: state.search_params['sorts']).on :change do |e|
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
                MultiSelect(placeholder: "Szukam", name: 'for_kinds[]', selection: state.search_params['for_kinds'], options: Commons.account_kinds).on :change do |e|
                  mutate.search_params['for_kinds'] = e.to_n
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