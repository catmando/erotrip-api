class GroupsIndex < Hyperloop::Router::Component

  state groups: []
  state total: 0
  state current_page: 1
  state per_page: 12
  state blocking: false
  state search_params: {
    gender:           [],
    gender_opposite:  [],
    where:            '',
    age:              [20, 30],
    distance:         30,
    height:           [],
    look:             [],
    interests:        []
  }

  after_mount do
    mutate.blocking true
    fetch_groups
  end

  def fetch_groups
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

  def search_changed terms
    if terms['sorts'] != state.search_params['sorts'] && state.current_page != 1
      mutate.current_page 1
    end
    mutate.search_params terms
    fetch_groups
  end

  def page_changed page
    mutate.current_page page
    fetch_groups
  end

  def render

    div.row do
      div.col_12.col_lg_9.ml_lg_auto do
        BlockUi(tag: "div", blocking: state.blocking) do

          GroupsIndexSearchBox(groups_count: state.total).on :change do |e|
            search_changed e.to_n
          end

          state.groups.each do |group|

            div.basic_container.basic_container_gray do
              div.details_wrapper do

                div.ea_flex.ea_align_center do
                  div
                  img(src: '/assets/girl.jpg')
                  div.text do
                    div.profile_info_wrapper do
                      div.profile_info do
                        div.profile_info_upper do
                          # div.person_status(class: "#{['away', 'online', 'offline'].sample}")
                          h4.mb_0 do
                            span { "#{group.name}" }
                            # span.text_gray { "#{Time.now.year - (group.birth_year || Time.now.year)}" }
                          end
                          i.ero_verified_border_gray.ml_2.f_s_30 do
                            span.path1
                            span.path2
                            span.path3
                          end
                        end
                        div.profile_info_lower.mb_3 do
                          # span.text_gray { "#{group_age(group)}, " }
                          # span.text_gray { group.city.to_s }
                        end
                      end
                    end

                    p.text_book.text_gray do
                      'Hydroderm is the highly desired anti_aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'
                    end
                  end
                end

                button.btn.icon_only.btn_container.text_white.white_border.secondary_bg.btn_top(type: "button") do
                  i.ero_messages.f_s_18
                end
                div.btn_group_wrapper do
                  button.btn.icon_only.btn_wrapped.btn_group(type: "button") do
                    i.ero_alert_circle_outline
                  end
                end
              end
            end
          end

          Pagination(page: state.current_page, per_page: state.per_page, total: state.total).on :change do |e|
            page_changed e.to_n
          end

        end
      end
    end

  end
end