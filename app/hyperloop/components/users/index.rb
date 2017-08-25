class UsersIndex < Hyperloop::Router::Component

  state users: []
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
    fetch_users
  end

  def fetch_users
    mutate.blocking true
    FetchResources.run(resource_type: 'User', page: state.current_page, per_page: state.per_page, terms: state.search_params)
    .then do |data|
      mutate.blocking false
      mutate.total data['count']
      mutate.users data['resources'].map{ |u| User.new(u) }
      `setTimeout(function(){window.scrollTo(0,0)}, 50)`
    end.fail do |e|
      mutate.blocking false
      mutate.users []
      mutate.total 0
      `toast.error('Nie udało się pobrać użytkowników.')`
    end
  end

  def search_changed terms
    if terms['sorts'] != state.search_params['sorts'] && state.current_page != 1
      mutate.current_page 1
    end
    mutate.search_params terms
    fetch_users
  end

  def page_changed page
    mutate.current_page page
    fetch_users
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

          UsersSearchBox(users_count: state.total).on :change do |e|
            search_changed e.to_n
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