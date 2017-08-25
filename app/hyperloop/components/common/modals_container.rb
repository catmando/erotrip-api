class ModalsContainer < Hyperloop::Router::Component
  before_update do
    puts 'UPDATING STORES CONTRAINER'
  end

  def render
    div do
      div do
        if ToastContainer
          ToastContainer(position: 'bottom-center', autoClose: 4000)
        end
      end
      if RootStore.opened_modals['login']
        div do
          LoginModal()
        end
      end
      if RootStore.opened_modals['registration']
        div do
          RegistrationModal()
        end
      end
      if RootStore.opened_modals['reset_password']
        div do
          ResetPasswordModal()
        end
      end
      if RootStore.opened_modals['auth_warning']
        div do
          AuthWarningModal()
        end
      end
      if RootStore.opened_modals['groups_new']
        div do
          GroupsNewModal()
        end
      end
    end
  end
end

