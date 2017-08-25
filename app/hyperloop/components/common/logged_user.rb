class LoggedUser < Hyperloop::Component

  after_mount do
    CurrentUserStore.init_current_user
  end

  def open_log_in_modal
    RootStore.open_modal('login')
    # `$('#login-modal').modal('show')`
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
    RootStore.open_modal('registration')
  end

  def render_not_logged_view
    span do
      div(class: 'logged-out') do
        a(class: "mt-0 mb-0 text-secondary f-s-16 underline") do
          'Dołącz do nas!'
        end.on :click do |e|
          register
        end
        P(class: 'mt-0 mb-0') do
          span { 'Masz już konto? ' }
          a(class: 'text-primary') { 'Zaloguj się' }.on :click do |e|
            open_log_in_modal
          end
        end
      end
    end
  end

  def render_logged_view
    div(class: "logged-in") do
      div(class: "logged-in-buttons") do
        button(class: "btn btn-outline-primary btn-outline-gray btn-menu icon-only with-label d-xs-none d-md-inline-flex d-xl-none", type: "button") do
          i(class: "ero-menu")
          div(class: 'button-label empty')
        end
        div(class: 'divider hidden-sm-down hidden-xl-up')

        button(class: "btn btn-outline-primary btn-outline-gray btn-messages icon-only with-label d-xs-none d-md-inline-flex d-xl-none", type: "button") do
          i(class: "ero-messages")
          div(class: 'button-label') { '2' }
        end
        div(class: 'divider hidden-sm-down')
      end

      div(class: 'profile') do
        div(class: 'profile-details') do
          img(src: 'assets/girl.jpg')
          div(class: 'profile-more-details-wrapper') do
            div(class: 'profile-more-details') do
              span(class: 'profile-name') { (CurrentUserStore.current_user || User.new).name }
              button(class: 'btn btn-outline-primary btn-outline-gray icon-only btn-settings fadeable', type: "button") do
                i(class: 'ero-settings')
              end
              button(class: 'btn btn-outline-primary btn-outline-gray icon-only d-xl-none fadeable', type: "button") do
                i(class: 'ero-log-out')
              end.on :click do |e|
                log_out(e)
              end
            end
            a(class: 'profile-log-out text-secondary-i f-s-12 underline d-xs-none d-xl-block') do
              'Wyloguj się'
            end.on :click do |e|
              log_out(e)
            end
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

