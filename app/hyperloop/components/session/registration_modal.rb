  class RegistrationModal < Hyperloop::Component

    state :user do
      { birth_year: '', kind: '', birth_year_second_person: '' }
    end
    state errors: {}
    state blocking: false

    after_mount do
      mutate.blocking(false)
      `$('#registration-modal').modal({backdrop: 'static', show: true})`
    end

    before_unmount do
      mutate.user({ birth_year: '', kind: '', birth_year_second_person: '' })
      mutate.errors({})
      mutate.blocking(false)
    end

    def close_modal
      `$('#registration-modal').modal('hide')`
      RootStore.close_modal('registration')
    end

    def register
      unless state.blocking
        mutate.blocking(true)
        mutate.errors({})
        ProcessRegistration.run(state.user)
          .then do |response|
            mutate.blocking(false)
            `toast.success('Zarejestrowaliśmy i zalogowaliśmy Cię! Witamy w EroTrip.')`
            close_modal
          end
          .fail do |e|
            mutate.blocking(false)
            `toast.error('Nie udało się zarejestrować.')`
            if e.is_a?(HTTP)
              if JSON.parse(e.body)['id'].present?
                CurrentUserStore.current_user_id! JSON.parse(e.body)['id']
                close_modal
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
      RootStore.open_modal('login')
      close_modal
    end

    def reset_password
      RootStore.open_modal('reset_password')
      close_modal
    end

    def birth_dates
      ((Time.now - 60.years).year..(Time.now - 18.years).year).to_a.reverse
    end

    def account_kinds
      [
        {label: 'Kobieta', value: 'woman'},
        {label: 'Mężczyzna', value: 'man'},
        {label: 'Para hetero', value: 'couple'},
        {label: 'Para kobiet', value: 'women_couple'},
        {label: 'Para mężczyzn', value: 'men_couple'},
        {label: 'TGSV', value: 'tgsv'}
      ]
    end

    def render_not_logged_view
      SPAN do
        DIV.modal_body.modal_body_registration do
          if (state.errors || {})['base'].present?
            DIV.alert.alert_danger do
              (state.errors || {})['base']
            end
          end
          FORM do
            DIV.form_group do
              Select(placeholder: "Rodzaj konta", options: account_kinds, selection: state.user['kind'], className: "form-control #{'is-invalid' if (state.errors || {})['kind'].present?}").on :change do |e|
                mutate.user['kind'] = e.to_n || ''
                mutate.errors['kind'] = nil
              end
              if (state.errors || {})['kind'].present?
                DIV.invalid_feedback do
                  (state.errors || {})['kind'].to_s;
                end
              end
            end

            DIV.row do

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['name'], type: "text", class: "#{'is-invalid' if (state.errors || {})['name'].present?}", placeholder: "Imię").on :key_up do |e|
                    mutate.user['name'] = e.target.value
                    mutate.errors['name'] = nil
                  end
                  if (state.errors || {})['name'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['name'].to_s;
                    end
                  end
                end
              end

              DIV.col do
                DIV.form_group do
                  Select(placeholder: "Rok urodzenia", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year'], className: "form-control #{'is-invalid' if (state.errors || {})['birth_year'].present?}").on :change do |e|
                    mutate.user['birth_year'] = e.to_n || nil
                    mutate.errors['birth_year'] = nil
                  end
                  if (state.errors || {})['birth_year'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['birth_year'].to_s;
                    end
                  end
                end
              end

            end

            DIV.row(class: "#{'d-none' if !(state.user['kind'].present? && !['woman', 'man'].include?(state.user['kind']))}") do

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['name_second_person'], type: "text", class: "#{'is-invalid' if (state.errors || {})['name_second_person'].present?}", placeholder: "Imię drugiej osoby").on :key_up do |e|
                    mutate.user['name_second_person'] = e.target.value
                    mutate.errors['name_second_person'] = nil
                  end
                  if (state.errors || {})['name_second_person'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['name_second_person'].to_s;
                    end
                  end
                end
              end

              DIV.col do
                DIV.form_group do
                  Select(placeholder: "Rok urodzenia drugiej osoby", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year_second_person']).on :change do |e|
                    mutate.user['birth_year_second_person'] = e.to_n || nil
                    mutate.errors['birth_year_second_person'] = nil
                  end
                  if (state.errors || {})['birth_year_second_person'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['birth_year_second_person'].to_s;
                    end
                  end
                end
              end

            end

            DIV.row do

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['city'], type: "city", class: "#{'is-invalid' if (state.errors || {})['city'].present?}", placeholder: "Miejscowość").on :key_up do |e|
                    mutate.user['city'] = e.target.value
                    mutate.errors['city'] = nil
                  end
                  if (state.errors || {})['city'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['city'].to_s;
                    end
                  end
                end
              end

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['email'], type: "email", class: "#{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
                    mutate.user['email'] = e.target.value
                    mutate.errors['email'] = nil
                  end
                  if (state.errors || {})['email'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['email'].to_s;
                    end
                  end
                end
              end

            end

            DIV.row do

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['password'], type: "password", class: "#{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :key_up do |e|
                    mutate.user['password'] = e.target.value
                    mutate.errors['password'] = nil
                  end
                  if (state.errors || {})['password'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['password'].to_s;
                    end
                  end
                end
              end

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['password_confirmation'], type: "password", class: "#{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Powtórz hasło").on :key_up do |e|
                    mutate.user['password_confirmation'] = e.target.value
                    mutate.errors['password_confirmation'] = nil
                  end
                  if (state.errors || {})['password_confirmation'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['password_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            DIV.row do

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['pin'], type: "number", class: "#{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN bezpieczeństwa").on :key_up do |e|
                    mutate.user['pin'] = e.target.value
                    mutate.errors['pin'] = nil
                  end
                  if (state.errors || {})['pin'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['pin'].to_s;
                    end
                  end
                end
              end

              DIV.col do
                DIV.form_group do
                  INPUT.form_control(defaultValue: state.user['pin_confirmation'], type: "number", class: "#{'is-invalid' if (state.errors || {})['pin_confirmation'].present?}", placeholder: "Powtórz PIN").on :key_up do |e|
                    mutate.user['pin_confirmation'] = e.target.value
                    mutate.errors['pin_confirmation'] = nil
                  end
                  if (state.errors || {})['pin_confirmation'].present?
                    DIV.invalid_feedback do
                      (state.errors || {})['pin_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            P do
              "Nadaj PIN składający się z minimum 4 cyfr, który będzie wymagany do odzyskania hasła. Dzięki niemu niepożądane osoby nie będą mogły sprawdzić czy Twój e-mail jest w naszej bazie."
            end

            DIV.form_check.form_check_inline.w_80p.ml_10p do
              LABEL.form_check_label(class: "#{'is-invalid' if (state.errors || {})['terms_acceptation'].present?}") do
                INPUT.form_check_input(defaultValue: state.user['terms_acceptation'], type: "checkbox").on :change do |e|
                  mutate.user['terms_acceptation'] = e.target.checked
                  mutate.errors['terms_acceptation'] = nil
                end
                SPAN do
                  DIV do
                    SPAN { 'Akceptuję' }
                    A(href: "", target: '_blank') { ' regulamin ' }
                    SPAN { 'oraz oświadczam, że mam ukończone 18 lat.' }
                  end
                end
              end
              if (state.errors || {})['terms_acceptation'].present?
                DIV.invalid_feedback do
                  (state.errors || {})['terms_acceptation'].to_s;
                end
              end
            end

            DIV.text_center do
              BlockUi(tag: "div", blocking: state.blocking) do
                BUTTON.btn.btn_secondary.btn_cons.mt_4.mb_4(type: "submit") do
                  'Zarejestruj się'
                end
              end
            end
          end.on :submit do |e|
            e.prevent_default
            register
          end
          P.text_center do
            SPAN {'Nie pamiętasz hasła? '}
            A.text_primary do
              'Zrestartuj hasło'
            end.on :click do |e|
              reset_password
            end
          end
          P.text_center do
            SPAN {'Masz już konto? '}
            A.text_primary do
              'Zaloguj się'
            end.on :click do |e|
              log_in
            end
          end
        end
      end
    end

    def render_logged_view
      SPAN do
        DIV.modal_body do
          P(class: 'text-center') { 'Jesteś aktualnie zalogowany! Wyloguj się, by przejść proces rejestracji' }
        end
        DIV.modal_footer.text_center do
          BUTTON.btn.btn_secondary.btn_cons.mt_3.mb_3(type: "button") do
            'Zamknij okno'
          end.on :click do
            close_modal
          end
        end
      end
    end

    def render
      DIV.modal.fade(id: 'registration-modal', role: "dialog", tabIndex: "-1") do
        DIV.modal_dialog(role: "document") do
          DIV.modal_content do
            DIV.modal_header do
              H5.modal_title { 'Zarejestruj się' }
              BUTTON.close(type: "button") do
                SPAN do
                  I.ero_cross.f_s_20.d_inline_block.rotated_45deg
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

