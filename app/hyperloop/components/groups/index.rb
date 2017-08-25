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

    div(class: 'row') do
      div(class: 'col-12 col-lg-9 ml-lg-auto') do
        BlockUi(tag: "div", blocking: state.blocking) do

          GroupsIndexSearchBox(groups_count: state.total).on :change do |e|
            search_changed e.to_n
          end

          state.groups.each do |group|

            div(class: 'basic-container basic-container-gray') do
              div(class: 'details-wrapper') do

                div(class: 'ea-flex ea-align_center') do
                  div
                  img(src: Commons.photo_version(group.photo, 'rect_160') || '/assets/girl.jpg')
                  div(class: 'text') do
                    div(class: 'profile-info-wrapper') do
                      div(class: 'profile-info') do
                        div(class: 'profile-info-upper') do
                          # div.person_status(class: "#{['away', 'online', 'offline'].sample}")
                          h4(class: 'mb-0') do
                            span { "#{group.name}" }
                            # span.text_gray { "#{Time.now.year - (group.birth_year || Time.now.year)}" }
                          end
                          # i.ero_verified_border_gray.ml_2.f_s_30 do
                          #   span.path1
                          #   span.path2
                          #   span.path3
                          # end
                        end
                        div(class: 'profile-info-lower mb-3') do
                          # span.text_gray { "#{group_age(group)}, " }
                          # span.text_gray { group.city.to_s }
                        end
                      end
                    end

                    p(class: 'text-book text-gray') do
                      "#{group.desc}"
                      # br
                      # div {" >> #{group.photo} <<"}
                      # div {" >> #{group.photo.class.name} <<"}
                      # div { ">> #{group.photo.gsub('=>', ':').gsub('nil', 'null')} << " }
                      # div { ">> #{Commons.photo_version(group.photo, 'rect_160')} << " }
                      # " >> #{group.photo.class.name} <<"
                      # br
                      # " >> #{group.photo['rect_160']} <<"
                    end
                  end
                end

                button(class: 'btn icon-only btn-container text-white white-border secondary-bg btn-top', type: 'button') do
                  i(class: 'ero-messages f-s-18')
                end
                div(class: 'btn-group-wrapper') do
                  button(class: 'btn icon-only btn-wrapped btn-group', type: "button") do
                    i(class: 'ero-alert-circle-outline')
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