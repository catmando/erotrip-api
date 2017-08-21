  class LoggedUser < Hyperloop::Component


    before_mount do
      # any initialization particularly of state variables goes here.
      # this will execute on server (prerendering) and client.
    end

    after_mount do
      CurrentUserStore.init_current_user
      # connect_session
      # any client only post rendering initialization goes here.
      # i.e. start timers, HTTP requests, and low level jquery operations etc.
    end

    before_update do
      # called whenever a component will be re-rerendered
    end

    before_unmount do
      # cleanup any thing (i.e. timers) before component is destroyed
    end

    def open_log_in_modal
      `$('#login-modal').modal('show')`
    end

    def log_out(event)
      puts 'will log out'
      event.prevent_default()
      ProcessLogout.run
    end

    def register
      `$('#registration-modal').modal('show')`
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

        # # LOGIN MODAL
        # DIV(id: 'login-modal', class: 'modal fadeable', role: "dialog", tabIndex: "-1") do
        #   DIV(class: 'modal-dialog', role: "document") do
        #     DIV(class: 'modal-content') do
        #       DIV(class: 'modal-header') do
        #         H5(class: 'modal-title') { 'Logowanie' }
        #         BUTTON(class: 'close', 'data-dismiss' => "modal", type: "button") do
        #           SPAN do
        #             I(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
        #           end
        #         end
        #       end
        #       DIV(class: 'modal-body') do
        #         'tu bedzie formularz'
        #       end
        #       DIV(class: 'modal-footer') do
        #         BUTTON(class: 'btn btn-secondary', 'data-dismiss' => "modal", type: "button") { 'Zamknij' }
        #         BUTTON(class: 'btn btn-primary', type: "button") do
        #           'Zaloguj'
        #         end.on :click do |e|
        #           log_in
        #         end
        #       end
        #     end
        #   end
        # end
      end
    end

    def render_logged_view
      DIV(class: "logged-in") do
        DIV(class: "logged-in-buttons") do
          BUTTON(class: "btn btn-outline-primary btn-outline-gray btn-menu icon-only with-label hidden-sm-down hidden-xl-up", type: "button") do
            I(class: "ero-menu")
            DIV(class: 'button-label empty')
          end
          DIV(class: 'divider hidden-sm-down hidden-xl-up')

          BUTTON(class: "btn btn-outline-primary btn-outline-gray btn-messages icon-only with-label hidden-sm-down hidden-xl-up", type: "button") do
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
                SPAN(class: 'profile-name') { (CurrentUserStore.current_user || User.new).full_name }
                BUTTON(class: 'btn btn-outline-primary btn-outline-gray icon-only btn-settings fadeable', type: "button") do
                  I(class: 'ero-settings')
                end
                BUTTON(class: 'btn btn-outline-primary btn-outline-gray icon-only hidden-xl-up fadeable', type: "button") do
                  I(class: 'ero-log-out')
                end.on :click do |e|
                  log_out(e)
                end
              end
              A(class: 'profile-log-out text-secondary-i f-s-12 underline hidden-lg-down') do
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

