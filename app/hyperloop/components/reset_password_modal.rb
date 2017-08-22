  class ResetPasswordModal < Hyperloop::Component

    state credentials: {}
    state errors: {}

    after_mount do
      `$('#reset-password-modal').modal({backdrop: 'static', show: true})`
    end

    before_unmount do
      mutate.credentials({})
      mutate.errors({})
    end

    def close_modal
      `$('#reset-password-modal').modal('hide')`
      RootStore.close_modal('reset_password')
    end

    def reset_password
      mutate.errors {}
      ProcessResetPassword.run(email: state.credentials['email'], password: state.credentials['password'], password_confirmation: state.credentials['password_confirmation'], pin: state.credentials['pin'])
        .then do |response|
          close_modal
        end
        .fail do |e|
          if e.is_a?(Exception) && e.message
            errors = JSON.parse(e.message.gsub('=>', ':'))
            errors.each do |k, v|
              errors[k] = v.join('; ') if v.is_a?(Array)
            end
            mutate.errors errors
          end
          {}
        end
    end

    def log_in
      RootStore.open_modal('login')
      close_modal
    end

    def render_not_logged_view
      SPAN do
        DIV(class: 'modal-body modal-body-reset_password') do
          if (state.errors || {})['base'].present?
            DIV(class: "alert alert-danger") do
              (state.errors || {})['base']
            end
          end
          P { "Did you read the DaVinci Code or maybe see the movie? Did it get you interested in history and secret" }
          DIV(class: "form-group") do
            INPUT(defaultValue: state.credentials['email'], type: "email", class: "form-control #{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
              mutate.credentials['email'] = e.target.value
            end
            if (state.errors || {})['email'].present?
              DIV(class: 'invalid-feedback') do
                (state.errors || {})['email'].to_s;
              end
            end
          end
          DIV(class: "form-group") do
            INPUT(defaultValue: state.credentials['pin'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN ustalony przy rejestracji").on :key_up do |e|
              mutate.credentials['pin'] = e.target.value
            end
            if (state.errors || {})['pin'].present?
              DIV(class: 'invalid-feedback') do
                (state.errors || {})['pin'].to_s;
              end
            end
          end

          DIV(class: 'row') do
            DIV(class: 'col') do
              DIV(class: "form-group") do
                INPUT(defaultValue: state.credentials['password'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Nowe hasło").on :key_up do |e|
                  mutate.credentials['password'] = e.target.value
                end
                if (state.errors || {})['password'].present?
                  DIV(class: 'invalid-feedback') do
                    (state.errors || {})['password'].to_s;
                  end
                end
              end
            end
            DIV(class: 'col') do
              DIV(class: "form-group") do
                INPUT(defaultValue: state.credentials['password_confirmation'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Potwierdź nowe hasło").on :key_up do |e|
                  mutate.credentials['password_confirmation'] = e.target.value
                end
                if (state.errors || {})['password_confirmation'].present?
                  DIV(class: 'invalid-feedback') do
                    (state.errors || {})['password_confirmation'].to_s;
                  end
                end
              end
            end
          end
          DIV(class: 'text-center') do
            BUTTON(class: 'btn btn-secondary btn-cons mt-4 mb-4', type: "button") do
              'Zrestartuj hasło'
            end.on :click do |e|
              reset_password
            end
          end
          P(class: 'text-center') do
            SPAN {'Przypomniałeś/aś sobie hasło? '}
            A(class: 'text-primary') do
              'Zaloguj się'
            end.on :click do |e|
              log_in
            end
          end
          # P(class: "text-center") do
          #   SPAN {'Nie masz konta? '}
          #   A(class: 'text-primary') do
          #     'Zarejestruj się'
          #   end.on :click do |e|
          #     register
          #   end
          # end
        end
      end
    end

    def render_logged_view
      SPAN do
        DIV(class: 'modal-body') do
          P(class: 'text-center') { 'Super! Jesteś zalogowany' }
        end
        DIV(class: 'modal-footer text-center') do
          BUTTON(class: 'btn btn-secondary btn-cons mt-3 mb-3', type: "button") do
            'Zamknij okno'
          end.on :click do
            close_modal
          end
        end
      end
    end

    def render
      DIV(id: 'reset-password-modal', class: "modal fadeable", role: "dialog", tabIndex: "-1") do
        DIV(class: 'modal-dialog', role: "document") do
          DIV(class: 'modal-content') do
            DIV(class: 'modal-header') do
              H5(class: 'modal-title') { 'Nie pamiętasz hasła?' }
              BUTTON(class: 'close', type: "button") do
                SPAN do
                  I(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
                end
              end.on :click do
                close_modal
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

