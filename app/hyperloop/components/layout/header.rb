class Header < Hyperloop::Router::Component

  def render
    div(class: 'row') do
      div(class: 'col-12 col-xl-9 ml-xl-auto') do
        div(class: 'featured streach-me') do
          div(class: 'patch')
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
          div(class: 'img-wrapper') do
            a(href: '#') do
              img(src: '/assets/girl.jpg')
            end
          end
        end
      end
    end
  end

end