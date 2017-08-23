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
        DIV(class: 'modal-body modal-body-registration') do
          if (state.errors || {})['base'].present?
            DIV(class: "alert alert-danger") do
              (state.errors || {})['base']
            end
          end
          FORM do
            DIV(class: "form-group") do
              Select(placeholder: "Rodzaj konta", options: account_kinds, selection: state.user['kind'], className: "form-control #{'is-invalid' if (state.errors || {})['kind'].present?}").on :change do |e|
                mutate.user['kind'] = e.to_n || ''
                mutate.errors['kind'] = nil
              end
              if (state.errors || {})['kind'].present?
                DIV(class: 'invalid-feedback') do
                  (state.errors || {})['kind'].to_s;
                end
              end
            end

            DIV(class: 'row') do

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['name'], type: "text", class: "form-control #{'is-invalid' if (state.errors || {})['name'].present?}", placeholder: "Imię").on :key_up do |e|
                    mutate.user['name'] = e.target.value
                    mutate.errors['name'] = nil
                  end
                  if (state.errors || {})['name'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['name'].to_s;
                    end
                  end
                end
              end

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  Select(placeholder: "Rok urodzenia", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year'], className: "form-control #{'is-invalid' if (state.errors || {})['birth_year'].present?}").on :change do |e|
                    mutate.user['birth_year'] = e.to_n || nil
                    mutate.errors['birth_year'] = nil
                  end
                  if (state.errors || {})['birth_year'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['birth_year'].to_s;
                    end
                  end
                end
              end

            end

            DIV(class: "row #{'d-none' if !(state.user['kind'].present? && !['woman', 'man'].include?(state.user['kind']))}") do

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['name_second_person'], type: "text", class: "form-control #{'is-invalid' if (state.errors || {})['name_second_person'].present?}", placeholder: "Imię drugiej osoby").on :key_up do |e|
                    mutate.user['name_second_person'] = e.target.value
                    mutate.errors['name_second_person'] = nil
                  end
                  if (state.errors || {})['name_second_person'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['name_second_person'].to_s;
                    end
                  end
                end
              end

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  Select(placeholder: "Rok urodzenia drugiej osoby", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year_second_person']).on :change do |e|
                    mutate.user['birth_year_second_person'] = e.to_n || nil
                    mutate.errors['birth_year_second_person'] = nil
                  end
                  if (state.errors || {})['birth_year_second_person'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['birth_year_second_person'].to_s;
                    end
                  end
                end
              end

            end

            DIV(class: 'row') do

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['city'], type: "city", class: "form-control #{'is-invalid' if (state.errors || {})['city'].present?}", placeholder: "Miejscowość").on :key_up do |e|
                    mutate.user['city'] = e.target.value
                    mutate.errors['city'] = nil
                  end
                  if (state.errors || {})['city'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['city'].to_s;
                    end
                  end
                end
              end

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['email'], type: "email", class: "form-control #{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
                    mutate.user['email'] = e.target.value
                    mutate.errors['email'] = nil
                  end
                  if (state.errors || {})['email'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['email'].to_s;
                    end
                  end
                end
              end

            end

            DIV(class: 'row') do

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['password'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :key_up do |e|
                    mutate.user['password'] = e.target.value
                    mutate.errors['password'] = nil
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
                  INPUT(defaultValue: state.user['password_confirmation'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Powtórz hasło").on :key_up do |e|
                    mutate.user['password_confirmation'] = e.target.value
                    mutate.errors['password_confirmation'] = nil
                  end
                  if (state.errors || {})['password_confirmation'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['password_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            DIV(class: 'row') do

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['pin'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN bezpieczeństwa").on :key_up do |e|
                    mutate.user['pin'] = e.target.value
                    mutate.errors['pin'] = nil
                  end
                  if (state.errors || {})['pin'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['pin'].to_s;
                    end
                  end
                end
              end

              DIV(class: 'col') do
                DIV(class: "form-group") do
                  INPUT(defaultValue: state.user['pin_confirmation'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin_confirmation'].present?}", placeholder: "Powtórz PIN").on :key_up do |e|
                    mutate.user['pin_confirmation'] = e.target.value
                    mutate.errors['pin_confirmation'] = nil
                  end
                  if (state.errors || {})['pin_confirmation'].present?
                    DIV(class: 'invalid-feedback') do
                      (state.errors || {})['pin_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            P do
              "Nadaj PIN składający się z minimum 4 cyfr, który będzie wymagany do odzyskania hasła. Dzięki niemu niepożądane osoby nie będą mogły sprawdzić czy Twój e-mail jest w naszej bazie."
            end

            DIV(class: "form-check form-check-inline w-80p ml-10p") do
              LABEL(class: "form-check-label #{'is-invalid' if (state.errors || {})['terms_acceptation'].present?}") do
                INPUT(defaultValue: state.user['terms_acceptation'], class: 'form-check-input', type: "checkbox").on :change do |e|
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
                DIV(class: 'invalid-feedback') do
                  (state.errors || {})['terms_acceptation'].to_s;
                end
              end
            end

            DIV(class: 'text-center') do
              BlockUi(tag: "div", blocking: state.blocking) do
                BUTTON(class: 'btn btn-secondary btn-cons mt-4 mb-4', type: "submit") do
                  'Zarejestruj się'
                end
              end
            end
          end.on :submit do |e|
            e.prevent_default
            register
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
            SPAN {'Masz już konto? '}
            A(class: 'text-primary') do
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
        DIV(class: 'modal-body') do
          P(class: 'text-center') { 'Jesteś aktualnie zalogowany! Wyloguj się, by przejść proces rejestracji' }
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
      DIV(id: 'registration-modal', class: 'modal fade', role: "dialog", tabIndex: "-1") do
        DIV(class: 'modal-dialog', role: "document") do
          DIV(class: 'modal-content') do
            DIV(class: 'modal-header') do
              H5(class: 'modal-title') { 'Zarejestruj się' }
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

