  class ResetPasswordModal < Hyperloop::Component
    include BaseModal

    state credentials: {}
    state errors: {}

    def title
      'Nie pamiętasz hasła?'
    end

    def render_modal
      if CurrentUserStore.current_user.present?
        render_logged_view
      else
        render_not_logged_view
      end
    end

    def render_not_logged_view
      span do
        div(class: 'modal-body modal-body-reset_password') do
          if (state.errors || {})['base'].present?
            div(class: "alert alert-danger") do
              (state.errors || {})['base']
            end
          end
          p { "Did you read the DaVinci Code or maybe see the movie? Did it get you interested in history and secret" }
          form do
            div(class: "form-group") do
              input(defaultValue: state.credentials['email'], type: "email", class: "form-control #{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
                mutate.credentials['email'] = e.target.value
              end
              if (state.errors || {})['email'].present?
                div(class: 'invalid-feedback') do
                  (state.errors || {})['email'].to_s;
                end
              end
            end
            div(class: "form-group") do
              input(defaultValue: state.credentials['pin'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN ustalony przy rejestracji").on :key_up do |e|
                mutate.credentials['pin'] = e.target.value
              end
              if (state.errors || {})['pin'].present?
                div(class: 'invalid-feedback') do
                  (state.errors || {})['pin'].to_s;
                end
              end
            end

            div(class: 'row') do
              div(class: 'col') do
                div(class: "form-group") do
                  input(defaultValue: state.credentials['password'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Nowe hasło").on :key_up do |e|
                    mutate.credentials['password'] = e.target.value
                  end
                  if (state.errors || {})['password'].present?
                    div(class: 'invalid-feedback') do
                      (state.errors || {})['password'].to_s;
                    end
                  end
                end
              end
              div(class: 'col') do
                div(class: "form-group") do
                  input(defaultValue: state.credentials['password_confirmation'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Potwierdź nowe hasło").on :key_up do |e|
                    mutate.credentials['password_confirmation'] = e.target.value
                  end
                  if (state.errors || {})['password_confirmation'].present?
                    div(class: 'invalid-feedback') do
                      (state.errors || {})['password_confirmation'].to_s;
                    end
                  end
                end
              end
            end
            div(class: 'text-center') do
              BlockUi(tag: "div", blocking: state.blocking) do
                button(class: 'btn btn-secondary btn-cons mt-4 mb-4', type: "submit") do
                  'Zrestartuj hasło'
                end
              end
            end
          end.on :submit do |e|
            e.prevent_default
            reset_password
          end
          p(class: 'text-center') do
            span {'Przypomniałeś/aś sobie hasło? '}
            a(class: 'text-primary') do
              'Zaloguj się'
            end.on :click do |e|
              log_in
            end
          end
        end
      end
    end

    def render_logged_view
      span do
        div(class: 'modal-body') do
          p(class: 'text-center') { 'Super! Jesteś zalogowany' }
        end
        div(class: 'modal-footer text-center') do
          button(class: 'btn btn-secondary btn-cons mt-3 mb-3', type: "button") do
            'Zamknij okno'
          end.on :click do
            close
          end
        end
      end
    end

    def reset_password
      unless state.blocking
        mutate.blocking(true)
        mutate.errors {}
        ProcessResetPassword.run(email: state.credentials['email'], password: state.credentials['password'], password_confirmation: state.credentials['password_confirmation'], pin: state.credentials['pin'])
          .then do |response|
            mutate.blocking(false)
            `toast.success('Super! Hasło zostało zmienione, możesz się teraz zalogować.')`
            log_in
          end
          .fail do |e|
            mutate.blocking(false)
            `toast.error('Nie udało się zmienić hasła.')`
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
    end

    def log_in
      ModalsService.open_modal(LoginModal, { proc_to_call: params.proc_to_call })
      close
    end

  end

