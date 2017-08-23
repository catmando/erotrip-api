class LoggedUser < Hyperloop::Component

  after_mount do
    CurrentUserStore.init_current_user
  end

  def open_log_in_modal
    RootStore.open_modal('login')
    # `$('#login-modal').modal('show')`
  end

  def log_out(event)
    puts 'will log out'
    event.prevent_default()
    ProcessLogout.run
  end

  def register
    RootStore.open_modal('registration')
  end

  def render_not_logged_view
    SPAN do
      DIV(class: 'logged-out') do
        A(class: "mt-0 mb-0 text-secondary f-s-16 underline") do
          'Dołącz do nas!'
        end.on :click do |e|
          register
        end
        P(class: 'mt-0 mb-0') do
          SPAN { 'Masz już konto? ' }
          A(class: 'text-primary') { 'Zaloguj się' }.on :click do |e|
            open_log_in_modal
          end
        end
      end
    end
  end

  def render_logged_view
    DIV(class: "logged-in") do
      DIV(class: "logged-in-buttons") do
        BUTTON(class: "btn btn-outline-primary btn-outline-gray btn-menu icon-only with-label d-xs-none d-md-inline-flex d-xl-none", type: "button") do
          I(class: "ero-menu")
          DIV(class: 'button-label empty')
        end
        DIV(class: 'divider hidden-sm-down hidden-xl-up')

        BUTTON(class: "btn btn-outline-primary btn-outline-gray btn-messages icon-only with-label d-xs-none d-md-inline-flex d-xl-none", type: "button") do
          I(class: "ero-messages")
          DIV(class: 'button-label') { '2' }
        end
        DIV(class: 'divider hidden-sm-down')
      end

      DIV(class: 'profile') do
        DIV(class: 'profile-details') do
          IMG(src: 'assets/girl.jpg')
          DIV(class: 'profile-more-details-wrapper') do
            DIV(class: 'profile-more-details') do
              SPAN(class: 'profile-name') { (CurrentUserStore.current_user || User.new).name }
              BUTTON(class: 'btn btn-outline-primary btn-outline-gray icon-only btn-settings fadeable', type: "button") do
                I(class: 'ero-settings')
              end
              BUTTON(class: 'btn btn-outline-primary btn-outline-gray icon-only d-xl-none fadeable', type: "button") do
                I(class: 'ero-log-out')
              end.on :click do |e|
                log_out(e)
              end
            end
            A(class: 'profile-log-out text-secondary-i f-s-12 underline d-xs-none d-xl-block') do
              'Wyloguj się'
            end.on :click do |e|
              log_out(e)
            end
          end
        end
      end
      DIV(class: 'divider')
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

