  class LoginModal < Hyperloop::Component



    after_mount do
      # any client only post rendering initialization goes here.
      # i.e. start timers, HTTP requests, and low level jquery operations etc.
    end

    before_update do
      # called whenever a component will be re-rerendered
    end

    before_unmount do
      # cleanup any thing (i.e. timers) before component is destroyed
    end

    def log_in
      puts 'will log in'
      CurrentUserStore.set_current_user User.new(first_name: 'Zakochana', last_name: 'Ewelka')
      `setTimeout(function(){
        $('#login-modal').modal('hide')
      }, 2000)`
    end

    def render_not_logged_view
      'tu bedzie formularz'
    end

    def render_logged_view
      'Super! Zostałeś zalogowany'
    end

    def render
      DIV(id: 'login-modal', class: 'modal fadeable', role: "dialog", tabIndex: "-1") do
        DIV(class: 'modal-dialog', role: "document") do
          DIV(class: 'modal-content') do
            DIV(class: 'modal-header') do
              H5(class: 'modal-title') { 'Logowanie' }
              BUTTON(class: 'close', 'data-dismiss' => "modal", type: "button") do
                SPAN do
                  I(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
                end
              end
            end
            DIV(class: 'modal-body') do
              if CurrentUserStore.current_user.present?
                render_logged_view
              else
                render_not_logged_view
              end
            end
            DIV(class: 'modal-footer') do
              BUTTON(class: 'btn btn-secondary', 'data-dismiss' => "modal", type: "button") { 'Zamknij' }
              BUTTON(class: 'btn btn-primary', type: "button") do
                'Zaloguj'
              end.on :click do |e|
                log_in
              end
            end
          end
        end
      end
    end
  end

