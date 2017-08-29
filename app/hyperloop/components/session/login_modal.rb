class LoginModal < Hyperloop::Component
  include BaseModal

  state credentials: {}
  state errors: {}

  def title
    'Zaloguj się'
  end

  def render_modal
    if CurrentUserStore.current_user.present?
      render_logged_view
    else
      render_not_logged_view
    end
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
        FORM do
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
            INPUT(defaultValue: state.credentials['password'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :key_up do |e|
              mutate.credentials['password'] = e.target.value
            end
            if (state.errors || {})['password'].present?
              DIV(class: 'invalid-feedback') do
                (state.errors || {})['password'].to_s;
              end
            end
          end
          DIV(class: 'text-center') do
            DIV do
              state.blocking
            end
            BlockUi(tag: "div", blocking: state.blocking) do
              BUTTON(class: 'btn btn-secondary btn-cons mt-4 mb-4', type: "submit") do
                'Zaloguj się'
              end
            end
          end
        end.on :submit do |e|
          e.prevent_default
          log_in
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
          close
        end
      end
    end
  end

  def log_in
    unless state.blocking
      mutate.blocking(true)
      mutate.errors {}
      ProcessLogin.run(email: state.credentials['email'], password: state.credentials['password'])
        .then do |response|
          mutate.blocking(false)
          `toast.success('Super! Udało się zalogować.')`
          params.proc_to_call.call()
          close
        end
        .fail do |e|
          mutate.blocking(false)
          `toast.error('Nie udało się zalogować')`
          if e.is_a?(HTTP)
            if JSON.parse(e.body)['id'].present?
              CurrentUserStore.current_user_id! JSON.parse(e.body)['id']
              `setTimeout(function(){
                $('#login-modal').modal('hide')
              }, 1000)`
            end
            mutate.errors JSON.parse(e.body)['errors']
          end
          if e.is_a?(Hyperloop::Operation::ValidationException)
            mutate.errors e.errors.message
          end
          {}
        end
    end
  end

  def register
    ModalsService.open_modal(RegistrationModal, { proc_to_call: params.proc_to_call })
    close
  end

  def reset_password
    ModalsService.open_modal(ResetPasswordModal, { proc_to_call: params.proc_to_call })
    close
  end

end

