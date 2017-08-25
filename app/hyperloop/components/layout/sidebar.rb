class Sidebar < Hyperloop::Router::Component

  def render
    div(class: 'sidebar open') do
      div(class: 'logo-wrapper') do
        button(class: "btn btn-outline-primary btn-outline-gray btn-menu icon-only with-label", type: "button") do
          i(class: "ero-menu")
          div(class: 'button-label empty')
        end
        button(class: "btn btn-outline-primary btn-outline-gray btn-close icon-only", type: "button") do
          i(class: "ero-cross rotated-45deg")
        end
        Link('/') do
          img(src: 'assets/logo.png')
        end
      end

      LoggedUser()

      div(class: 'menu') do
        button(class: 'btn btn-secondary btn-block') do
          'Dodaj wycieczkę'
        end

        ul(class: 'main-submenu') do
          li(class: 'menu-item') do
            NavLink('/', exact: true, active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-users')
              end
              div(class: 'label fadeable') {'Użytkownicy'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/trips', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-trips')
              end
              div(class: 'label fadeable') {'Wycieczki'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/groups', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-groups')
              end
              div(class: 'label fadeable') {'Grupy'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/hotline', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-hotline')
              end
              div(class: 'label fadeable') {'Hotline'}
            end
          end
        end

        button(class: 'btn btn-primary btn-block') do
          'Moje wycieczki'
        end

        ul(class: 'fadeable secondary-submenu') do
          li(class: 'menu-item') do
            NavLink('/messages', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-messages')
              end
              div(class: 'label fadeable') {'Wiadomości'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/notifications', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-notifications')
              end
              div(class: 'label fadeable') {'Powiadomienia'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/interested', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-heart-2')
              end
              div(class: 'label fadeable') {'Chcą Cię poznać'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/peeper', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-eye')
              end
              div(class: 'label fadeable') {'Podglądacz'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/new-people', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-new-people')
              end
              div(class: 'label fadeable') {'Nowe osoby'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/new-trips', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-new-trips')
              end
              div(class: 'label fadeable') {'Nowe wycieczki'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/unlocked', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero-unlocked')
              end
              div(class: 'label fadeable') {'Odblokowania'}
            end
          end

          li(class: 'menu-item') do
            NavLink('/anonymous', active_class: 'active') do
              div(class: 'icon-wrapper') do
                i(class: 'ero_locker')
              end
              div(class: 'label fadeable') {'Tryb anonimowy'}
            end
          end

        end
      end
    end
  end
end
