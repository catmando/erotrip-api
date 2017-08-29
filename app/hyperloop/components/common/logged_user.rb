class LoggedUser < Hyperloop::Component

  after_mount do
    CurrentUserStore.init_current_user
  end

  def open_log_in_modal
    ModalsService.open_modal(LoginModal, { proc_to_call: proc{ register() } })
  end

  def log_out(event)
    event.prevent_default()
    ProcessLogout.run.then do
      `toast.success('Wylogowaliśmy Cię z EroTrip.')`
    end.failed do
      `toast.success('Nie udało się wylogować.')`
    end
  end

  def register
    ModalsService.open_modal(RegistrationModal)
  end

  def render_not_logged_view
    span do
      div(class: 'logged-out') do
        a(class: 'text-secondary text-ellipsis mt-0 mb-0 f-s-16 underline') do
          'Dołącz do nas!'
        end.on :click do |e|
          register
        end
        p(class: 'text-ellipsis mt-0 mb-0') do
          span { 'Masz już konto? ' }
          a(class: 'text-primary') { 'Zaloguj się' }.on :click do |e|
            open_log_in_modal
          end
        end
      end

      div(class: 'logged-out-mini') do
        button(class: 'btn icon-only btn-outline-primary btn-outline-gray ', type: 'button') do
          i(class: 'ero-user f-s-20')
        end.on :click do |e|
          open_log_in_modal
        end
      end
    end
  end

  def render_logged_view
    div(class: "logged-in") do
      div(class: "logged-in-tablet-buttons d-none d-md-flex d-xl-none") do
        button(class: "btn btn-outline-primary btn-outline-gray btn-messages icon-only with-label", type: "button") do
          i(class: "ero-messages")
          div(class: 'button-label') { '2' }
        end
        div(class: 'divider')
        button(class: 'btn icon-only btn-outline-primary btn-outline-gray ', type: 'button') do
          i(class: "ero-log-out")
        end.on :click do |e|
          log_out(e)
        end
        div(class: 'divider')
      end

      div(class: 'profile') do
        img(src: 'assets/girl.jpg')
        div(class: 'profile-details-wrapper') do
          div(class: 'profile-details') do
            span(class: 'profile-name') { (CurrentUserStore.current_user || User.new).name }
            button(class: 'btn btn-outline-primary btn-outline-gray icon-only btn-settings fadeable', type: "button") do
              i(class: 'ero-settings f-s-18')
            end
            button(class: 'btn btn-outline-primary btn-outline-gray icon-only d-xl-none fadeable ml-2', type: "button") do
              i(class: 'ero-log-out')
            end.on :click do |e|
              log_out(e)
            end
          end
          a(class: 'profile-log-out text-secondary-i f-s-12 underline d-none d-xl-block') do
            'Wyloguj się'
          end.on :click do |e|
            log_out(e)
          end
        end
      end

      div(class: 'divider')
    end
  end

  def render
    if CurrentUserStore.current_user.present?
      render_logged_view
    else
      render_not_logged_view
    end
  end
end

