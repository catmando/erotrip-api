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
      div.row do
        div.col_12.col_lg_9.ml_lg_auto do

          div.group_details.streach_me do
            div.patch
            div.group_details_wrapper do
              h3.mt_0.d_md_none { 'TRIP' }
              div.ea_flex.ea_align_start do
                div
                a(href: '#') do
                  img(src: 'assets/girl.jpg')
                end
                div.text do
                  h2.mt_0.d_none.d_md_block { 'TRIP' }
                  p.text_book.text_gray.d_none.d_md_block  do
                    'Hydroderm is the highly desired anti_aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'
                  end
                  div.group_info.m do
                    p.mb_0 do
                      span.text_primary {'2310'}
                      span.text_gray {' użytkowników'}
                    end
                    p.mb_0 do
                      span.text_primary {'70'}
                      span.text_gray {' ukrytych'}
                    end
                    p.mb_0 do
                      span.text_primary {'Twój profil'}
                      span.text_gray {' publiczny'}
                    end
                  end
                end
              end

              button.btn.icon_only.btn_plus.btn_group(type: "button") do
                i.ero_cross
              end
              button.btn.icon_only.btn_eye.btn_group(type: "button") do
                i.ero_eye
              end
            end
          end

          GroupsShowSearchBox(users_count: 2311).on :change do |e|
            trigger_search e.to_n
          end

          div.row.people_wrapper do

            [0,1,2,3,4,5,6,7].each do |each_i|
              div.col_6.col_md_4.col_lg_4.col_xl_3 do
                div.person(class: "#{['locked', ''].sample}") do # can have class 'locked'
                  div.person_photo_wrapper do
                    div.person_actions do
                      button.btn.icon_only.btn_person.btn_heart.btn_group(type: "button") do
                        i.ero_heart
                      end
                      button.btn.icon_only.btn_person.btn_remove.btn_group.ml_2(type: "button") do
                        i.ero_cross
                      end
                    end
                    div.person_photo_amount.d_none.d_md_flex do
                      i.ero_photo_amount
                      span.amount {'6'}
                    end
                    div.locker do
                      i.ero_locker
                    end
                    IMG(src: 'assets/girl.jpg')
                  end

                  div.person_info.ea_flex.ea_flex_align_start.ea_just_start do
                    div.person_status.online(class: "#{['online', 'offline', 'away'].sample}")  # available statuses: 'online', 'offline', 'away'
                    div.person_details do
                      div.person_name_age do
                        h5.mt_0.mb_0.d_inline_block.person_name do
                          span {'Anna '}
                          span.coma.d_none.d_md_inline_block {', '}
                        end
                        h5.mt_0.mb_0.person_age.text_gray {'24'}
                      end
                      div.preson_city.text_gray.d_none.d_md_block {'Warszawa'}
                    end
                  end
                end
              end
            end

          end

          nav.mt_5 do
            ul.pagination.justify_content_between do
              li.page_item.previous.disabled do
                a.page_link(href: "#") do
                  i.ero_arrow_left.mr_3
                  span.d_none.d_md_inline_block {'Poprzednia strona'}
                end
              end

              div.page_wrapper do
                li.page_item.active do
                  a.page_link(href: "") {'1'}
                end
                li.page_item do
                  a.page_link(href: "") {'2'}
                end
                li.page_item do
                  a.page_link(href: "") {'3'}
                end
                li.page_item do
                  a.page_link(href: "") {'4'}
                end
                li.page_item do
                  a.page_link(href: "") {'5'}
                end
              end

              li.page_item.next do
                a.page_link(href: "") do
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