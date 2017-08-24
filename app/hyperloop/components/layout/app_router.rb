class AppRouter < Hyperloop::Router
  history :browser

  route do
    DIV do

      div.navbar.d_md_none do
        button.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.more(type: "button") do
          i.ero_menu
          div.button_label.empty
        end
        img(src: '/assets/logo.png')
        button.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.messages(type: "button") do
          i.ero_messages
          div.button_label {'2'}
        end
      end

      Route('/', exact: false, mounts: Sidebar)

      div.container.main_container do
        Route('/', exact: false, mounts: Header)

        # main routes
        Route('/', exact: true, mounts: UsersIndex)
        # Route('/users', mounts: Users)
        # Route('/trips', mounts: Trips)
        Route('/groups', mounts: GroupsShow) #temporarily
        Route('/hotline', mounts: Hotline)
        # Route('/messages', mounts: Messages)
        # Route('/notifications', mounts: Notifications)
        # Route('/interested', mounts: Interested)
        # Route('/peeper', mounts: Peeper)
        # Route('/new-people', mounts: NewPeople)
        # Route('/new-trips', mounts: NewTrips)
        # Route('/unlocked', mounts: Unlocked)
        # Route('/anonymous', mounts: Anonymous)

        Route('/', exact: false, mounts: Footer)
      end

      Route('/', exact: false, mounts: ModalsContainer)
    end
  end
end