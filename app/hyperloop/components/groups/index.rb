class GroupsIndex < Hyperloop::Router::Component

  state groups: []
  state total: 0
  state current_page: 1
  state per_page: 8
  state search_params: {
    name_cont:        '',
    for_kinds:        [],
    sorts:            'created_at desc'
  }

  def render
    groups_scope = Group.ransacked(state.search_params)

    div(class: 'row') do
      div(class: 'col-12 col-lg-9 ml-lg-auto') do

        GroupsIndexSearchBox(groups_count: groups_scope.count).on :change do |e|
          search_changed e.to_n
        end

        BlockUi(tag: "div", blocking: groups_scope.loading?) do
          groups_scope.limit(state.per_page).offset((state.current_page - 1) * state.per_page).each_with_index do |group, index|
            div(class: 'basic-container basic-container-gray') do
              div(class: 'details-wrapper') do

                div(class: 'ea-flex ea-align-center') do
                  div
                  img(src: group.photo_url)
                  div(class: 'text') do
                    div(class: 'profile-info-wrapper') do
                      div(class: 'profile-info') do
                        div(class: 'profile-info-upper') do
                          h4(class: 'mb-0') do
                            span { "#{group.name}" }
                          end
                        end
                        div(class: 'profile-info-lower mb-3') do
                          span(class: 'text-gray') do
                            Commons.account_kinds.select{ |kind| (group.try(:kinds) || []).include?(kind['value']) }.map{ |v| v['label'] }.join(', ')
                          end
                        end
                      end
                    end

                    p(class: 'text-book text-gray') do
                      group.desc
                      # "#{CurrentUserStore.current_user_id.present?} #{CurrentUserStore.current_user_id.present? && User.find(CurrentUserStore.current_user.try(:id)).group_ids.include?(group.id)}"
                    end
                  end
                end

                button(class: "btn icon-only btn-container text-white white-border btn-top #{false ? 'bg-gray-200' : 'secondary-bg'}", type: "button") do
                  # !group.has_user(CurrentUserStore.current_user_id.to_i)
                  i(class: "f-s-18 ero-cross")
                  # i(class: "f-s-18 #{CurrentUserStore.current_user_id.present? && User.find(CurrentUserStore.current_user_id).group_ids.include?(group.id) ? 'ero-pencil' : 'ero-cross'}")
                end.on :click do |e|
                  join_group(group)
                end
                Link("/groups/#{group.id}") do
                  div(class: 'btn-group-wrapper') do
                    button(class: 'btn icon-only btn-wrapped btn-group', type: "button") do
                      i(class: 'ero-eye')
                    end
                  end
                end
              end
            end
          end

        end

        Pagination(page: state.current_page, per_page: state.per_page, total: groups_scope.count).on :change do |e|
          page_changed e.to_n
        end

      end
    end

  end

  def join_group(group)
    ModalsService.open_modal(GroupsJoinModal, { group: group })
  end

  def search_changed terms
    if terms['sorts'] != state.search_params['sorts'] && state.current_page != 1
      mutate.current_page 1
    end
    mutate.search_params terms
  end

  def page_changed page
    mutate.current_page page
  end
end