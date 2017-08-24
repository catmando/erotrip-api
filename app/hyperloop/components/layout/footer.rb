class Footer < Hyperloop::Router::Component

  def render
    div.row do
      div.col_12.col_lg_9.ml_lg_auto do

        div.featured.featured_large.streach_me.mt_5 do
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


        div.footer.streach_me.d_none.d_xl_block do
          div.patch
          div.row.no_gutters do
            div.col do
              div.footer_stats_wrapper do
                div.footer_stats do
                  div.name {'Użytkowników'}
                  div.number {'2 335 542'}
                end
              end
            end
            div.col do
              div.footer_stats_wrapper do
                div.footer_stats do
                  div.name {'Zweryfikowanych'}
                  div.number {'2 115 542'}
                end
              end
            end
            div.col do
              div.footer_stats_wrapper do
                div.footer_stats do
                  div.name {'Online'}
                  div.number {'15 123'}
                end
              end
            end
            div.col do
              div.footer_stats_wrapper do
                div.footer_stats do
                  div.name {'Ukrytych'}
                  div.number {'75 123'}
                end
              end
            end
            div.col do
              div.footer_stats_wrapper do
                div.footer_stats do
                  div.name {'Wycieczek'}
                  div.number {'92 123'}
                end
              end
            end
          end
        end

        div.footer_info.d_lg_none do
          div.footer_info_text do
            div.text_book.text_center {'Copyright 2017 © Erotrip.pl Wszystkie prawa zastrzeżone'}
            div.ea_flex.ea_just_center do
              button.btn.btn_link.text_gray(type: "button") {'Kontakt'}
              button.btn.btn_link.text_gray(type: "button") {'Regulamin'}
            end
          end
        end
      end
    end
  end

end