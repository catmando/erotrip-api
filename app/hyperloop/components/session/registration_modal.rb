  class RegistrationModal < Hyperloop::Component
    include BaseModal

    state :user do
      { birth_year: '', kind: '', birth_year_second_person: '' }
    end
    state errors: {}

    def title
      'Zarejestruj się'
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
        div.modal_body.modal_body_registration do
          if (state.errors || {})['base'].present?
            div.alert.alert_danger do
              (state.errors || {})['base']
            end
          end
          form do
            div.form_group do
              Select(placeholder: "Rodzaj konta", options: Commons.account_kinds, selection: state.user['kind'], className: "form-control #{'is-invalid' if (state.errors || {})['kind'].present?}").on :change do |e|
                mutate.user['kind'] = e.to_n || ''
                mutate.errors['kind'] = nil
              end
              if (state.errors || {})['kind'].present?
                div.invalid_feedback do
                  (state.errors || {})['kind'].to_s;
                end
              end
            end

            div.row do

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['name'], type: "text", class: "#{'is-invalid' if (state.errors || {})['name'].present?}", placeholder: "Imię").on :key_up do |e|
                    mutate.user['name'] = e.target.value
                    mutate.errors['name'] = nil
                  end
                  if (state.errors || {})['name'].present?
                    div.invalid_feedback do
                      (state.errors || {})['name'].to_s;
                    end
                  end
                end
              end

              div.col do
                div.form_group do
                  Select(placeholder: "Rok urodzenia", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year'], className: "form-control #{'is-invalid' if (state.errors || {})['birth_year'].present?}").on :change do |e|
                    mutate.user['birth_year'] = e.to_n || nil
                    mutate.errors['birth_year'] = nil
                  end
                  if (state.errors || {})['birth_year'].present?
                    div.invalid_feedback do
                      (state.errors || {})['birth_year'].to_s;
                    end
                  end
                end
              end

            end

            div.row(class: "#{'d-none' if !(state.user['kind'].present? && !['woman', 'man'].include?(state.user['kind']))}") do

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['name_second_person'], type: "text", class: "#{'is-invalid' if (state.errors || {})['name_second_person'].present?}", placeholder: "Imię drugiej osoby").on :key_up do |e|
                    mutate.user['name_second_person'] = e.target.value
                    mutate.errors['name_second_person'] = nil
                  end
                  if (state.errors || {})['name_second_person'].present?
                    div.invalid_feedback do
                      (state.errors || {})['name_second_person'].to_s;
                    end
                  end
                end
              end

              div.col do
                div.form_group do
                  Select(placeholder: "Rok urodzenia drugiej osoby", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year_second_person']).on :change do |e|
                    mutate.user['birth_year_second_person'] = e.to_n || nil
                    mutate.errors['birth_year_second_person'] = nil
                  end
                  if (state.errors || {})['birth_year_second_person'].present?
                    div.invalid_feedback do
                      (state.errors || {})['birth_year_second_person'].to_s;
                    end
                  end
                end
              end

            end

            div.row do

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['city'], type: "city", class: "#{'is-invalid' if (state.errors || {})['city'].present?}", placeholder: "Miejscowość").on :key_up do |e|
                    mutate.user['city'] = e.target.value
                    mutate.errors['city'] = nil
                  end
                  if (state.errors || {})['city'].present?
                    div.invalid_feedback do
                      (state.errors || {})['city'].to_s;
                    end
                  end
                end
              end

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['email'], type: "email", class: "#{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
                    mutate.user['email'] = e.target.value
                    mutate.errors['email'] = nil
                  end
                  if (state.errors || {})['email'].present?
                    div.invalid_feedback do
                      (state.errors || {})['email'].to_s;
                    end
                  end
                end
              end

            end

            div.row do

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['password'], type: "password", class: "#{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :key_up do |e|
                    mutate.user['password'] = e.target.value
                    mutate.errors['password'] = nil
                  end
                  if (state.errors || {})['password'].present?
                    div.invalid_feedback do
                      (state.errors || {})['password'].to_s;
                    end
                  end
                end
              end

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['password_confirmation'], type: "password", class: "#{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Powtórz hasło").on :key_up do |e|
                    mutate.user['password_confirmation'] = e.target.value
                    mutate.errors['password_confirmation'] = nil
                  end
                  if (state.errors || {})['password_confirmation'].present?
                    div.invalid_feedback do
                      (state.errors || {})['password_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            div.row do

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['pin'], type: "number", class: "#{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN bezpieczeństwa").on :key_up do |e|
                    mutate.user['pin'] = e.target.value
                    mutate.errors['pin'] = nil
                  end
                  if (state.errors || {})['pin'].present?
                    div.invalid_feedback do
                      (state.errors || {})['pin'].to_s;
                    end
                  end
                end
              end

              div.col do
                div.form_group do
                  input.form_control(defaultValue: state.user['pin_confirmation'], type: "number", class: "#{'is-invalid' if (state.errors || {})['pin_confirmation'].present?}", placeholder: "Powtórz PIN").on :key_up do |e|
                    mutate.user['pin_confirmation'] = e.target.value
                    mutate.errors['pin_confirmation'] = nil
                  end
                  if (state.errors || {})['pin_confirmation'].present?
                    div.invalid_feedback do
                      (state.errors || {})['pin_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            p do
              "Nadaj PIN składający się z minimum 4 cyfr, który będzie wymagany do odzyskania hasła. Dzięki niemu niepożądane osoby nie będą mogły sprawdzić czy Twój e-mail jest w naszej bazie."
            end

            div.form_check.form_check_inline.w_80p.ml_10p do
              label.form_check_label(class: "#{'is-invalid' if (state.errors || {})['terms_acceptation'].present?}") do
                input.form_check_input(defaultValue: state.user['terms_acceptation'], type: "checkbox").on :change do |e|
                  mutate.user['terms_acceptation'] = e.target.checked
                  mutate.errors['terms_acceptation'] = nil
                end
                span do
                  div do
                    span { 'Akceptuję' }
                    A(href: "", target: '_blank') { ' regulamin ' }
                    span { 'oraz oświadczam, że mam ukończone 18 lat.' }
                  end
                end
              end
              if (state.errors || {})['terms_acceptation'].present?
                div.invalid_feedback do
                  (state.errors || {})['terms_acceptation'].to_s;
                end
              end
            end

            div.text_center do
              BlockUi(tag: "div", blocking: state.blocking) do
                button.btn.btn_secondary.btn_cons.mt_4.mb_4(type: "submit") do
                  'Zarejestruj się'
                end
              end
            end
          end.on :submit do |e|
            e.prevent_default
            register
          end
          p.text_center do
            span {'Nie pamiętasz hasła? '}
            a.text_primary do
              'Zrestartuj hasło'
            end.on :click do |e|
              reset_password
            end
          end
          p.text_center do
            span {'Masz już konto? '}
            a.text_primary do
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
        div.modal_body do
          P(class: 'text-center') { 'Jesteś aktualnie zalogowany! Wyloguj się, by przejść proces rejestracji' }
        end
        div.modal_footer.text_center do
          button.btn.btn_secondary.btn_cons.mt_3.mb_3(type: "button") do
            'Zamknij okno'
          end.on :click do
            close
          end
        end
      end
    end

    def register
      unless state.blocking
        mutate.blocking(true)
        mutate.errors({})
        ProcessRegistration.run(state.user)
          .then do |response|
            mutate.blocking(false)
            `toast.success('Zarejestrowaliśmy i zalogowaliśmy Cię! Witamy w EroTrip.')`
            params.proc_to_call.call()
            close
          end
          .fail do |e|
            mutate.blocking(false)
            `toast.error('Nie udało się zarejestrować.')`
            if e.is_a?(HTTP)
              if JSON.parse(e.body)['id'].present?
                CurrentUserStore.current_user_id! JSON.parse(e.body)['id']
                close
              end
              errors = JSON.parse(e.body)['errors']
              errors.each do |k, v|
                errors[k] = v.join('; ')
              end
              mutate.errors errors

            elsif e.is_a?(Hyperloop::Operation::ValidationException)
              puts e.errors.message
              mutate.errors e.errors.message
            end
            {}
          end
      end
    end

    def log_in
      ModalsService.open_modal(LoginModal, { proc_to_call: params.proc_to_call })
      close
    end

    def reset_password
      ModalsService.open_modal(ResetPasswordModal, { proc_to_call: params.proc_to_call })
      close
    end

    def birth_dates
      ((Time.now - 60.years).year..(Time.now - 18.years).year).to_a.reverse
    end

  end

