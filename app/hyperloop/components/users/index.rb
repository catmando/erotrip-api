class UsersIndex < Hyperloop::Router::Component

  state users: []
  state total: 0
  state current_page: 1
  state per_page: 25
  state blocking: false

  after_mount do
    mutate.blocking true
    FetchUsers.run(page: 1, per_page: 2)
    .then do |data|
      mutate.blocking false
      mutate.total data.total
      mutate.users data.users
    end.fail do |e|
      puts "e.inspect: #{e.inspect}"
      puts "e.stacktrace: #{e.try(:stacktrace)}"
      puts "e.message: #{e.try(:message)}"
      mutate.blocking false
      mutate.users []
      `toast.error('Nie udało się pobrać użytkowników.')`
    end
  end

  def render

    BlockUi(tag: "div", blocking: state.blocking) do
      div.row do
        div.col_12.col_lg_9.ml_lg_auto do

          form.search do
            div.search_header do
              div.info.f_s_16 do
                span.text_primary {'2310'}
                span.text_gray {' użytkowników'}
              end

              div.search_input do
                button.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.more.mr_3(type: "submit") do
                  i.ero_search
                end
              end
            end
          end

          state.users.each do |user|
            div.hotline.hotline_gray do
              div.details_wrapper do

                div.ea_flex.ea_align_center do
                  div
                  img(src: '/assets/girl.jpg')
                  div.text do
                    div.profile_info_wrapper do
                      div.profile_info do
                        div.profile_info_upper do
                          div.person_status(class: "#{['away', 'online', 'offfline'].sample}")
                          h4.mb_0 do
                            span { "#{user.name}, " }
                            span.text_gray { user.age }
                          end
                          i.ero_verified_border_gray.ml_2.f_s_30 do
                            span.path1
                            span.path2
                            span.path3
                          end
                        end
                        div.profile_info_lower.mb_3 do
                          span.text_gray {'2 dni temu, '}
                          span.text_gray {'Poznań'}
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

          nav.mt_6.mb_6 do
            ul.pagination.justify_content_between do
              li.page_item.previous.disabled do
                a.page_link(href:"#") do
                  i.ero_arrow_left.mr_3
                  span.d_none.d_md_inline_block {'Poprzednia strona'}
                end
              end

              div.page_wrapper do
                li.page_item.active do
                  a.page_link(href: "#") {'1'}
                end
                li.page_item do
                  a.page_link(href: "#") {'2'}
                end
                li.page_item do
                  a.page_link(href: "#") {'3'}
                end
                li.page_item do
                  a.page_link(href: "#") {'4'}
                end
                li.page_item do
                  a.page_link(href: "#") {'5'}
                end
              end

              li.page_item.next do
                a.page_link(href:"") do
                  span.d_none.d_md_inline_block {'Następna strona'}
                  i.ero_arrow_right.ml_3
                end
              end
            end
          end
        end
      end
    end

  end
end