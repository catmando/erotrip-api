class ModalsContainer < Hyperloop::Component
  before_update do
    puts 'UPDATING STORES CONTRAINER'
  end

  def render
    DIV do
      DIV do
        ToastContainer(position: 'bottom-center', autoClose: 4000)
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
    end
  end
end

