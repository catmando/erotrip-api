class GroupsShow < Hyperloop::Router::Component
  # state users: []
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
  # state mounted: false

  # after_mount do
  #   mutate.search_params({
  #     gender:           [],
  #     gender_opposite:  [],
  #     where:            '',
  #     age:              [20, 30],
  #     distance:         30,
  #     height:           [],
  #     look:             [],
  #     interests:        []
  #     })
  #   mutate.mounted true
  # end

  # before_unmount
  #   mutate.mounted false
  # end

  def trigger_search
    `console.log('will do searching')`
  end

  def process_search

  end

  def render
    span do
      div(class: 'row') do
        div(class: 'col-12 col-xl-9 ml-xl-auto') do

          div(class: 'group-details streach-me') do
            div(class: 'patch')
            div(class: 'group-details-wrapper') do
              h3(class: 'mt-0 d-md-none') { 'TRIP' }
              div(class: 'ea-flex ea-align-start') do
                div
                a(href: '#') do
                  img(src: 'assets/girl.jpg')
                end
                div(class: 'text') do
                  h2(class: 'mt-0 d-none d-md-block') { 'TRIP' }
                  p(class: 'text-book text-gray d-none d-md-block') do
                    'Hydroderm is the highly desired anti_aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'
                  end
                  div(class: 'group-info m') do
                    p(class: 'mb-0') do
                      span(class: 'text-primary') {'2310'}
                      span(class: 'text-gray') {' użytkowników'}
                    end
                    p(class: 'mb-0') do
                      span(class: 'text-primary') {'70'}
                      span(class: 'text-gray') {' ukrytych'}
                    end
                    p(class: 'mb-0') do
                      span(class: 'text-primary') {'Twój profil'}
                      span(class: 'text-gray') {' publiczny'}
                    end
                  end
                end
              end

              button(class: 'btn icon-only btn-plus btn-group', type: "button") do
                i(class: 'ero-cross')
              end
              button(class: 'btn icon-only btn-eye btn-group', type: "button") do
                i(class: 'ero-eye')
              end
            end
          end

          GroupsShowSearchBox(users_count: 2311).on :change do |e|
            trigger_search e.to_n
          end

          div(class: 'row people-wrapper') do

            [0,1,2,3,4,5,6,7].each do |each_i|
              div(class: 'col-6 col-md-4 col-lg-4 col-xl-3') do
                div(class: "person #{['locked', ''].sample}") do # can have class 'locked'
                  div(class: 'person-photo-wrapper') do
                    div(class: 'person-actions') do
                      button(class: 'btn icon-only btn-person btn-heart btn-group', type: "button") do
                        i(class: 'ero-heart')
                      end
                      button(class: 'btn icon-only btn-person btn-remove btn-group ml-2', type: "button") do
                        i(class: 'ero-cross')
                      end
                    end
                    div(class: 'person-photo-amount d-none d-md-flex') do
                      i(class: 'ero-photo-amount')
                      span(class: 'amount') {'6'}
                    end
                    div(class: 'locker') do
                      i(class: 'ero-locker')
                    end
                    img(src: 'assets/girl.jpg')
                  end

                  div(class: 'person-info ea-flex ea-flex-align-start ea-just-start') do
                    div(class: "person-status online #{['online', 'offline', 'away'].sample}")  # available statuses: 'online', 'offline', 'away'
                    div(class: 'person-details') do
                      div(class: 'person-name-age') do
                        h5(class: 'mt-0 mb-0 d-inline-block person-name') do
                          span {'Anna '}
                          span(class: 'coma d-none d-md-inline-block') {', '}
                        end
                        h5(class: 'mt-0 mb-0 person-age text-gray') {'24'}
                      end
                      div(class: 'preson-city text-gray d-none d-md-block') {'Warszawa'}
                    end
                  end
                end
              end
            end

          end

          nav(class: 'mt-5') do
            ul(class: 'pagination justify-content-between') do
              li(class: 'page-item previous disabled') do
                a(class: 'page-link', href: "#") do
                  i(class: 'ero-arrow-left mr-3')
                  span(class: 'd-none d-md-inline-block') {'Poprzednia strona'}
                end
              end

              div(class: 'page-wrapper') do
                li(class: 'page-item active') do
                  a(class: 'page-link', href: "") {'1'}
                end
                 li(class: 'page-item') do
                  a(class: 'page-link', href: "") {'2'}
                end
                 li(class: 'page-item') do
                  a(class: 'page-link', href: "") {'3'}
                end
                 li(class: 'page-item') do
                  a(class: 'page-link', href: "") {'4'}
                end
                 li(class: 'page-item') do
                  a(class: 'page-link', href: "") {'5'}
                end
              end

              li(class: 'page-item next') do
                a(class: 'page-link', href: "") do
                  span(class: 'd-none d-md-inline-block') {'Następna strona'}
                  i(class: 'ero-arrow-right ml-3')
                end
              end
            end
          end

        end
      end
    end

  end
end