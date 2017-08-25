class Hotline < Hyperloop::Router::Component

  def render

    div(class: 'row') do
      div(class: 'col-12 col-lg-9 ml-lg-auto') do

        div(class: 'basic-container streach-me') do
          div(class: 'patch')
          div(class: 'details-wrapper') do

            div(class: 'ea-flex ea-align-center') do
              div
              a do
                img(src: '/assets/girl.jpg')
              end
              div(class: 'text') do
                div(class: 'profile-info-wrapper') do
                  div(class: 'profile-info') do
                    div(class: 'profile-info-upper') do
                      div(class: 'person-status.away')
                      h4(class: 'mb-0') do
                        span {'Anna, '}
                        span(class: 'text-gray') {'18'}
                      end
                      i(class: 'ero-verified-border-gray ml-2 f-s-30') do
                        span(class: 'path1')
                        span(class: 'path2')
                        span(class: 'path2')
                      end
                    end
                    div(class: 'profile-info-lower mb-3') do
                      span.text-gray {'2 dni temu, '}
                      span.text-gray {'Poznań'}
                    end
                  end
                end

                p(class: 'text-book text-gray') {'Hydroderm is the highly desired anti-aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'}
              end
            end

            button(class: 'btn icon-only btn-container text-white primary-border secondary-bg btn-top', type: 'button') do
              i(class: 'ero-messages f-s-18')
            end

            div(class: 'btn-special-wrapper') do
              div(class: 'label text-primary') {'5/100'}
              button(class: 'btn icon-only btn-container text-primary primary-border white-bg', type: "button") do
                i(class: 'ero-chevron-double-right-2 f-s-15')
              end
              button(class: 'btn icon-only btn-container text-primary primary-border white-bg', type: "button") do
                i(class: 'ero-chevron-double-right f-s-15')
              end
            end
          end
        end

        [1, 2, 3, 4, 5].each do |photo|
          div(class: 'basic-container basic-container-gray') do
            div(class: 'details-wrapper') do

              div(class: 'ea-flex ea-align-center') do
                div
                img(src: '/assets/girl.jpg')
                div(class: 'text') do
                  div(class: 'profile-info-wrapper') do
                    div(class: 'profile-info') do
                      div(class: 'profile-info-upper') do
                        div(class: "person-status #{['away', 'online', 'offfline'].sample}")
                        h4(class: 'mb-0') do
                          span {'Anna, '}
                          span(class: 'text-gray') {'18'}
                        end
                        i(class: 'ero-verified-border-gray ml-2 f-s-30') do
                          span(class: 'path1')
                          span(class: 'path2')
                          span(class: 'path3')
                        end
                      end
                      div(class: 'profile-info-lower mb-3') do
                        span(class: 'text-gray') {'2 dni temu, '}
                        span(class: 'text-gray') {'Poznań'}
                      end
                    end
                  end

                  p(class: 'text-book text-gray') do
                    'Hydroderm is the highly desired anti-aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'
                  end
                end
              end

              button(class: 'btn icon-only btn-container text-white white-border secondary-bg btn-top', type: "button") do
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

      end
    end

  end
end