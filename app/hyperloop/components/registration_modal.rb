  class RegistrationModal < Hyperloop::Component

    state :user do
      { birth_year: '', kind: '', birth_year_second_person: '' }
    end
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

    def register
      mutate.errors {}
      puts state.user.inspect
      ProcessRegistration.run(state.user)
        .then do |response|
          puts 'SUCCESS'
          `setTimeout(function(){
            $('#registration-modal').modal('hide')
          }, 1000)`
        end
        .fail do |e|
          puts 'FAILED!'
          puts e.inspect
          # `console.log(e)`
          if e.is_a?(HTTP)
            puts JSON.parse(e.body)['id'].present?
            if JSON.parse(e.body)['id'].present?
              puts 'YOU ARE ALREADY SIGNED IN!'
              CurrentUserStore.current_user_id! JSON.parse(e.body)['id']
              `setTimeout(function(){
                $('#registration-modal').modal('hide')
              }, 1000)`
            end
            puts "YES, IT'S A HTTP"
            puts JSON.parse(e.body)['errors']
            mutate.errors JSON.parse(e.body)['errors']
            puts state.errors

          elsif e.is_a?(Hyperloop::Operation::ValidationException)
            puts 'HALO MAMY ERRORY!!!'
            puts e.errors.message.inspect
            mutate.errors e.errors.message
            puts 'PO MUTACJI'
            puts state.errors
          end
          {}
        end
    end

    def log_in
      `$('#registration-modal').modal('hide')`
      `$('#login-modal').modal('show')`
    end

    def reset_password
      puts 'will reset password'
      `$('#password-modal').modal('show')`
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
                INPUT(value: state.user['name'], type: "text", class: "form-control #{'is-invalid' if (state.errors || {})['name'].present?}", placeholder: "Imię").on :change do |e|
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
                INPUT(value: state.user['name_second_person'], type: "text", class: "form-control #{'is-invalid' if (state.errors || {})['name_second_person'].present?}", placeholder: "Imię drugiej osoby").on :change do |e|
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
                INPUT(value: state.user['city'], type: "city", class: "form-control #{'is-invalid' if (state.errors || {})['city'].present?}", placeholder: "Miejscowość").on :change do |e|
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
                INPUT(value: state.user['email'], type: "email", class: "form-control #{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :change do |e|
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
                INPUT(value: state.user['password'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :change do |e|
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
                INPUT(value: state.user['password_confirmation'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Powtórz hasło").on :change do |e|
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
                INPUT(value: state.user['pin'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN bezpieczeństwa").on :change do |e|
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
                INPUT(value: state.user['pin_confirmation'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin_confirmation'].present?}", placeholder: "Powtórz PIN").on :change do |e|
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

          DIV(class: "form-check form-check-inline") do
            LABEL(class: "form-check-label #{'is-invalid' if (state.errors || {})['terms_acceptation'].present?}") do
              INPUT(value: state.user['terms_acceptation'], class: 'form-check-input', type: "checkbox").on :change do |e|
                mutate.user['terms_acceptation'] = !state.user['terms_acceptation']
                puts e.target.value
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
            BUTTON(class: 'btn btn-secondary btn-cons mt-4 mb-4', type: "button") do
              'Zarejestruj się'
            end.on :click do |e|
              register
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
            SPAN {'Masz już konto? '}
            A(class: 'text-primary') do
              'Zaloguj się'
            end.on :click do |e|
              log_in
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
          P(class: 'text-center') { 'Jesteś aktualnie zalogowany! Wyloguj się, by przejść proces rejestracji' }
        end
        DIV(class: 'modal-footer text-center') do
          BUTTON(class: 'btn btn-secondary btn-cons mt-3 mb-3', 'data-dismiss' => "modal", type: "button") { 'Zamknij okno' }
        end
      end
    end

    def render
      DIV(id: 'registration-modal', class: 'modal fadeable', role: "dialog", tabIndex: "-1") do
        DIV(class: 'modal-dialog', role: "document") do
          DIV(class: 'modal-content') do
            DIV(class: 'modal-header') do
              H5(class: 'modal-title') { 'Zarejestruj się' }
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

