  class LoginModal < Hyperloop::Component

    state credentials: {}
    state errors: {}

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
      mutate.errors {}
      ProcessLogin.run(email: state.credentials['email'], password: state.credentials['password'])
        .then do |response|
          puts 'SUCCESS'
          `setTimeout(function(){
            $('#login-modal').modal('hide')
          }, 1000)`
        end
        .fail do |e|
          puts 'FAILED!'
          puts e.inspect
          puts "HTTP? #{e.is_a?(HTTP)}"
          puts JSON.parse(e.body)
          # `console.log(e)`
          if e.is_a?(HTTP)
            puts JSON.parse(e.body)['id'].present?
            if JSON.parse(e.body)['id'].present?
              puts 'YOU ARE ALREADY SIGNED IN!'
              CurrentUserStore.current_user_id! JSON.parse(e.body)['id']
              `setTimeout(function(){
                $('#login-modal').modal('hide')
              }, 1000)`
            end
            puts "YES, IT'S A HTTP"
            puts JSON.parse(e.body)['errors']
            mutate.errors JSON.parse(e.body)['errors']
            puts state.errors
          end
          if e.is_a?(Hyperloop::Operation::ValidationException)
            puts 'WE HAVE VALIDATION ERRORS!!!'
            puts e.errors.message.inspect
            mutate.errors e.errors.message
            puts 'AFTER MUTATION'
            puts state.errors
          end
          {}
        end
    end

    def register
      `$('#login-modal').modal('hide')`
      `$('#registration-modal').modal('show')`
    end

    def reset_password
      puts 'will reset password'
      `$('#password-modal').modal('show')`
    end

    def render_not_logged_view
      SPAN do
        DIV(class: 'modal-body modal-body-login') do
          if (state.errors || {})['base'].present?
            DIV(class: "alert alert-danger") do
              (state.errors || {})['base']
            end
          end
          P { "Did you read the DaVinci Code or maybe see the movie? Did it get you interested in history and secret" }
          DIV(class: "form-group") do
            INPUT(type: "email", class: "form-control #{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
              mutate.credentials['email'] = e.target.value
            end
            if (state.errors || {})['email'].present?
              DIV(class: 'invalid-feedback') do
                (state.errors || {})['email'].to_s;
              end
            end
          end
          DIV(class: "form-group") do
            INPUT(type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :key_up do |e|
              mutate.credentials['password'] = e.target.value
            end
            if (state.errors || {})['password'].present?
              DIV(class: 'invalid-feedback') do
                (state.errors || {})['password'].to_s;
              end
            end
          end
          DIV(class: 'text-center') do
            BUTTON(class: 'btn btn-secondary btn-cons mt-4 mb-4', type: "button") do
              'Zaloguj się'
            end.on :click do |e|
              log_in
            end
          end
          P(class: 'text-center') do
            SPAN {'Nie pamiętasz hasła? '}
            A(class: 'text-primary') do
              'Zrestartuj hasło'
            end.on :click do |e|
              reset_password
            end
          end
          P(class: "text-center") do
            SPAN {'Nie masz konta? '}
            A(class: 'text-primary') do
              'Zarejestruj się'
            end.on :click do |e|
              register
            end
          end
        end
        # DIV(class: 'modal-footer text-center') do
        #   # BUTTON(class: 'btn btn-secondary', 'data-dismiss' => "modal", type: "button") { 'Zamknij' }
        # end
      end
    end

    def render_logged_view
      SPAN do
        DIV(class: 'modal-body') do
          P(class: 'text-center') { 'Super! Zostałeś zalogowany' }
        end
        DIV(class: 'modal-footer text-center') do
          BUTTON(class: 'btn btn-secondary btn-cons mt-3 mb-3', 'data-dismiss' => "modal", type: "button") { 'Zamknij okno' }
        end
      end
    end

    def render
      DIV(id: 'login-modal', class: 'modal fadeable', role: "dialog", tabIndex: "-1") do
        DIV(class: 'modal-dialog', role: "document") do
          DIV(class: 'modal-content') do
            DIV(class: 'modal-header') do
              H5(class: 'modal-title') { 'Zaloguj się' }
              BUTTON(class: 'close', 'data-dismiss' => "modal", type: "button") do
                SPAN do
                  I(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
                end
              end
            end
            if CurrentUserStore.current_user.present?
              render_logged_view
            else
              render_not_logged_view
            end
          end
        end
      end
    end
  end

