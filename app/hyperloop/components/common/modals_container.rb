class ModalsContainer < Hyperloop::Router::Component
  before_update do
    puts 'UPDATING STORES CONTRAINER'
  end

  def render
    DIV do
      DIV do
        if ToastContainer
          ToastContainer(position: 'bottom-center', autoClose: 4000)
        end
      end
      if RootStore.opened_modals['login']
        DIV do
          LoginModal()
        end
      end
      if RootStore.opened_modals['registration']
        DIV do
          RegistrationModal()
        end
      end
      if RootStore.opened_modals['reset_password']
        DIV do
          ResetPasswordModal()
        end
      end
      if RootStore.opened_modals['auth_warning']
        DIV do
          AuthWarningModal()
        end
      end
      if RootStore.opened_modals['groups_new']
        DIV do
          GroupsNewModal()
        end
      end
    end
  end
end

