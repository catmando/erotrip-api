class Footer < Hyperloop::Router::Component

  def render
    div(class: 'row') do
      div(class: 'col-12 col-lg-9 ml-lg-auto') do

        div(class: 'featured featured-large streach-me mt-5') do
          div(class: 'patch')
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper d-none d-md-block') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper d-none d-md-block') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper d-none d-xl-block') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper d-none d-xl-block') do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
        end

        div(class: 'footer streach-me d-none d-xl-block') do
          div(class: 'patch')
          div(class: 'row no-gutters') do
            div(class: 'col') do
              div(class: 'footer-stats-wrapper') do
                div(class: 'footer-stats') do
                  div.name {'Użytkowników'}
                  div.number {'2 335 542'}
                end
              end
            end
            div(class: 'col') do
              div(class: 'footer-stats-wrapper') do
                div(class: 'footer-stats') do
                  div.name {'Zweryfikowanych'}
                  div.number {'2 115 542'}
                end
              end
            end
            div(class: 'col') do
              div(class: 'footer-stats-wrapper') do
                div(class: 'footer-stats') do
                  div.name {'Online'}
                  div.number {'15 123'}
                end
              end
            end
            div(class: 'col') do
              div(class: 'footer-stats-wrapper') do
                div(class: 'footer-stats') do
                  div.name {'Ukrytych'}
                  div.number {'75 123'}
                end
              end
            end
            div(class: 'col') do
              div(class: 'footer-stats-wrapper') do
                div(class: 'footer-stats') do
                  div.name {'Wycieczek'}
                  div.number {'92 123'}
                end
              end
            end
          end
        end

        div(class: 'footer-info d-lg-none') do
          div(class: 'footer-info-text') do
            div(class: 'text-book text-center') {'Copyright 2017 © Erotrip.pl Wszystkie prawa zastrzeżone'}
            div(class: 'ea-flex ea-just-center') do
              button(class: 'btn btn-link text-gray', type: 'button') {'Kontakt'}
              button(class: 'btn btn-link.text-gray', type: 'button') {'Regulamin'}
            end
          end
        end
      end
    end
  end

end