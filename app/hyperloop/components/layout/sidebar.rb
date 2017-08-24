class Sidebar < Hyperloop::Router::Component

  def render
    div(class: 'sidebar open') do
      div.logo_wrapper.d_none.d_xl_block do
        Link('/') do
          img(src: 'assets/logo.png')
        end
      end

      LoggedUser()

      div.menu do
        button.btn.btn_secondary.btn_block do
          'Dodaj wycieczkę'
        end

        ul.main_submenu do
          li.menu_item do
            NavLink('/users', active_class: 'active') do
              div.icon_wrapper do
                i.ero_users
              end
              div.label.fadeable {'Użytkownicy'}
            end
          end

          li.menu_item do
            NavLink('/trips', active_class: 'active') do
              div.icon_wrapper do
                i.ero_trips
              end
              div.label.fadeable {'Wycieczki'}
            end
          end

          li.menu_item do
            NavLink('/groups', active_class: 'active') do
              div.icon_wrapper do
                i.ero_groups
              end
              div.label.fadeable {'Grupy'}
            end
          end

          li.menu_item do
            NavLink('/hotline', active_class: 'active') do
              div.icon_wrapper do
                i.ero_hotline
              end
              div.label.fadeable {'Hotline'}
            end
          end
        end

        button.btn.btn_primary.btn_block do
          'Moje wycieczki'
        end

        ul.fadeable.secondary_submenu do
          li.menu_item do
            NavLink('/messages', active_class: 'active') do
              div.icon_wrapper do
                i.ero_messages
              end
              div.label.fadeable {'Wiadomości'}
            end
          end

          li.menu_item do
            NavLink('/notifications', active_class: 'active') do
              div.icon_wrapper do
                i.ero_notifications
              end
              div.label.fadeable {'Powiadomienia'}
            end
          end

          li.menu_item do
            NavLink('/interested', active_class: 'active') do
              div.icon_wrapper do
                i.ero_heart_2
              end
              div.label.fadeable {'Chcą Cię poznać'}
            end
          end

          li.menu_item do
            NavLink('/peeper', active_class: 'active') do
              div.icon_wrapper do
                i.ero_eye
              end
              div.label.fadeable {'Podglądacz'}
            end
          end

          li.menu_item do
            NavLink('/new-people', active_class: 'active') do
              div.icon_wrapper do
                i.ero_new_people
              end
              div.label.fadeable {'Nowe osoby'}
            end
          end

          li.menu_item do
            NavLink('/new-trips', active_class: 'active') do
              div.icon_wrapper do
                i.ero_new_trips
              end
              div.label.fadeable {'Nowe wycieczki'}
            end
          end

          li.menu_item do
            NavLink('/unlocked', active_class: 'active') do
              div.icon_wrapper do
                i.ero_unlocked
              end
              div.label.fadeable {'Odblokowania'}
            end
          end

          li.menu_item do
            NavLink('/anonymous', active_class: 'active') do
              div.icon_wrapper do
                i.ero_locker
              end
              div.label.fadeable {'Tryb anonimowy'}
            end
          end

        end
      end
    end
  end
end
