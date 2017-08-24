class UsersIndex < Hyperloop::Router::Component

  state users: []
  state total: 0
  state current_page: 1
  state per_page: 12
  state blocking: false

  after_mount do
    mutate.blocking true
    page_changed(state.current_page)
  end

  def page_changed page
    mutate.current_page page
    mutate.blocking true
    FetchUsers.run(page: page, per_page: state.per_page)
    .then do |data|
      mutate.blocking false
      mutate.total data['count']
      mutate.users data['users'].map{ |u| User.new(u) }
      `setTimeout(function(){window.scrollTo(0,0)}, 50)`
    end.fail do |e|
      mutate.blocking false
      mutate.users []
      mutate.total 0
      `toast.error('Nie udało się pobrać użytkowników.')`
    end
  end

  def user_age user
    if user.present?
      days = ((Time.now - user.created_at) / 1.day).to_i
      if days == 0
        "dziś"
      elsif days == 1
        "1 dzień temu"
      else
        "#{days} dni temu"
      end
    end
  end

  def render

    div.row do
      div.col_12.col_lg_9.ml_lg_auto do
        BlockUi(tag: "div", blocking: state.blocking) do

          form.search do
            div.search_header do
              div.info.f_s_16 do
                span.text_primary { state.total.to_s }
                span.text_gray {' użytkowników'}
              end

              div.search_input do
                button.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.more.mr_3(type: "submit") do
                  i.ero_search
                end
              end
            end
          end

          div.row.people_wrapper do

            state.users.each do |user|

              div.col_6.col_md_4.col_lg_4.col_xl_3 do
                div.person(class: "#{'locked' if user.private}") do
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
                      span.amount {'6'} # TODO: USER.PHOTOS.SIZE or sth like that
                    end
                    div.locker do
                      i.ero_locker
                    end
                    IMG(src: 'assets/girl.jpg') # TODO: USER.AVATAR_URL or sth like that
                  end

                  div.person_info.ea_flex.ea_flex_align_start.ea_just_start do
                    div.person_status.online(class: "#{['online', 'offline', 'away'].sample}")  # TODO: USER.STATUS or sth like that
                    div.person_details do
                      div.person_name_age do
                        h5.mt_0.mb_0.d_inline_block.person_name do
                          span { "#{user.name} " }
                          span.coma.d_none.d_md_inline_block {', '}
                        end
                        h5.mt_0.mb_0.person_age.text_gray { "#{Time.now.year - (user.birth_year || Time.now.year)}" }
                      end
                      div.preson_city.text_gray.d_none.d_md_block { user.city }
                    end
                  end
                end
              end

              # div.hotline.hotline_gray do
              #   div.details_wrapper do

              #     div.ea_flex.ea_align_center do
              #       div
              #       img(src: '/assets/girl.jpg')
              #       div.text do
              #         div.profile_info_wrapper do
              #           div.profile_info do
              #             div.profile_info_upper do
              #               div.person_status(class: "#{['away', 'online', 'offline'].sample}")
              #               h4.mb_0 do
              #                 span { "#{user.name}, " }
              #                 span.text_gray { "#{Time.now.year - (user.birth_year || Time.now.year)}" }
              #               end
              #               i.ero_verified_border_gray.ml_2.f_s_30 do
              #                 span.path1
              #                 span.path2
              #                 span.path3
              #               end
              #             end
              #             div.profile_info_lower.mb_3 do
              #               span.text_gray { "#{user_age(user)}, " }
              #               span.text_gray { user.city.to_s }
              #             end
              #           end
              #         end

              #         p.text_book.text_gray do
              #           'Hydroderm is the highly desired anti_aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'
              #         end
              #       end
              #     end

              #     button.btn.icon_only.btn_container.text_white.white_border.secondary_bg.btn_top(type: "button") do
              #       i.ero_messages.f_s_18
              #     end
              #     div.btn_group_wrapper do
              #       button.btn.icon_only.btn_wrapped.btn_group(type: "button") do
              #         i.ero_alert_circle_outline
              #       end
              #     end
              #   end
              # end

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