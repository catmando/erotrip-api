class Header < Hyperloop::Router::Component

  def render
    div.row do
      div.col_12.col_lg_9.ml_lg_auto do
        div.featured.streach_me do
          div.patch
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
          div.img_wrapper do
            a(href: '#') do
              img(src: 'assets/girl.jpg')
            end
          end
        end
      end
    end
  end

end