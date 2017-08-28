  class RegistrationModal < Hyperloop::Component

    state :user do
      { birth_year: '', kind: '', birth_year_second_person: '', city: '' }
    end
    state errors: {}
    state blocking: false

    state map_options: {
    	types: ['(cities)'],
    	componentRestrictions: {country: 'pl'}
    }

    state css_classes: {
	    root: 'google-places',
	    input: 'form-control',
	    autocompleteContainer: 'autocomplete-container'
	  }
	  # input: "form-control #{'is-invalid' if (state.errors || {})['city'].present?}",

	  state invalid_css_classes: {
	    root: 'google-places',
	    input: 'form-control is-invalid',
	    autocompleteContainer: 'autocomplete-container'
	  }

    after_mount do
      mutate.blocking(false)
      `$('#registration-modal').modal({backdrop: 'static', show: true})`
    end

    def changed(val)
    	# mutate.user['city'] = val
    	`GeocodeByAddress(#{val})
    		.then(results => GetLatLng(results[0]))
    		.then(({ lat, lng }) => console.log('Successfully got latitude and longitude', { lat, lng }))`
    	# `GeocodeByAddress(#{val})
    	# 	.then(results => GetLatLng(results[0]))
    	# 	.then(({ lat, lng }) =>
    	# 		console.log('Successfully got latitude and longitude', { lat, lng });
    	# 		return {lat, lon};
    	# 	)`
    	mutate.user['city'] = val

    	# GeocodeByAddress({address: state.user['city']})
    	# GeocodeByAddress({address: state.user['city']}).then do |response|
    	# 	`console.log(response)`
    	# end
    end

    def close_modal
      `$('#registration-modal').modal('hide')`
      mutate.user({ birth_year: '', kind: '', birth_year_second_person: '' })
      mutate.errors({})
      mutate.blocking(false)
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

    def render_not_logged_view
      span do
        div(class: 'modal-body modal-body-registration') do
          if (state.errors || {})['base'].present?
            div(class: 'alert alert-danger') do
              (state.errors || {})['base']
            end
          end
          form do
            div(class: 'form-group') do
              Select(placeholder: "Rodzaj konta", options: Commons.account_kinds, selection: state.user['kind'], className: "form-control #{'is-invalid' if (state.errors || {})['kind'].present?}").on :change do |e|
                mutate.user['kind'] = e.to_n || ''
                mutate.errors['kind'] = nil
              end
              if (state.errors || {})['kind'].present?
                div(class: "invalid-feedback") do
                  (state.errors || {})['kind'].to_s;
                end
              end
            end

            div(class: 'row') do

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['name'], type: "text", class: "form-control #{'is-invalid' if (state.errors || {})['name'].present?}", placeholder: "Imię").on :key_up do |e|
                    mutate.user['name'] = e.target.value
                    mutate.errors['name'] = nil
                  end
                  if (state.errors || {})['name'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['name'].to_s;
                    end
                  end
                end
              end

              div(class: 'col') do
                div(class: 'form-group') do
                  Select(placeholder: "Rok urodzenia", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year'], className: "form-control #{'is-invalid' if (state.errors || {})['birth_year'].present?}").on :change do |e|
                    mutate.user['birth_year'] = e.to_n || nil
                    mutate.errors['birth_year'] = nil
                  end
                  if (state.errors || {})['birth_year'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['birth_year'].to_s;
                    end
                  end
                end
              end

            end

            div(class: "row #{'d-none' if !(state.user['kind'].present? && !['woman', 'man'].include?(state.user['kind']))}") do

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['name_second_person'], type: "text", class: "form-control #{'is-invalid' if (state.errors || {})['name_second_person'].present?}", placeholder: "Imię drugiej osoby").on :key_up do |e|
                    mutate.user['name_second_person'] = e.target.value
                    mutate.errors['name_second_person'] = nil
                  end
                  if (state.errors || {})['name_second_person'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['name_second_person'].to_s;
                    end
                  end
                end
              end

              div(class: 'col') do
                div(class: 'form-group') do
                  Select(placeholder: "Rok urodzenia drugiej osoby", options: birth_dates.map{|year| {value: year, label: year} }, selection: state.user['birth_year_second_person']).on :change do |e|
                    mutate.user['birth_year_second_person'] = e.to_n || nil
                    mutate.errors['birth_year_second_person'] = nil
                  end
                  if (state.errors || {})['birth_year_second_person'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['birth_year_second_person'].to_s;
                    end
                  end
                end
              end

            end

            div(class: 'row') do

              div(class: 'col') do
              	div(class: 'form-group') do
	              	GooglePlacesAutocomplete(
	              		inputProps: { value: state.user['city'], onChange: proc{ |e| changed(e)} , placeholder: 'Miejscowość'}.to_n,
	              		options: state.map_options.to_n,
	              		googleLogo: false,
	              		classNames: (state.errors || {})['city'].present? ? state.invalid_css_classes.to_n : state.css_classes.to_n
	              	)

	                if (state.errors || {})['city'].present?
	                  div(class: "invalid-feedback") do
	                    (state.errors || {})['city'].to_s;
	                  end
	                end
	              end
              end

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['email'], type: "email", class: "form-control #{'is-invalid' if (state.errors || {})['email'].present?}", placeholder: "Adres e-mail").on :key_up do |e|
                    mutate.user['email'] = e.target.value
                    mutate.errors['email'] = nil
                  end
                  if (state.errors || {})['email'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['email'].to_s;
                    end
                  end
                end
              end

            end

            div(class: 'row') do

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['password'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password'].present?}", placeholder: "Hasło").on :key_up do |e|
                    mutate.user['password'] = e.target.value
                    mutate.errors['password'] = nil
                  end
                  if (state.errors || {})['password'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['password'].to_s;
                    end
                  end
                end
              end

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['password_confirmation'], type: "password", class: "form-control #{'is-invalid' if (state.errors || {})['password_confirmation'].present?}", placeholder: "Powtórz hasło").on :key_up do |e|
                    mutate.user['password_confirmation'] = e.target.value
                    mutate.errors['password_confirmation'] = nil
                  end
                  if (state.errors || {})['password_confirmation'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['password_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            div(class: 'row') do

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['pin'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin'].present?}", placeholder: "PIN bezpieczeństwa").on :key_up do |e|
                    mutate.user['pin'] = e.target.value
                    mutate.errors['pin'] = nil
                  end
                  if (state.errors || {})['pin'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['pin'].to_s;
                    end
                  end
                end
              end

              div(class: 'col') do
                div(class: 'form-group') do
                  input(defaultValue: state.user['pin_confirmation'], type: "number", class: "form-control #{'is-invalid' if (state.errors || {})['pin_confirmation'].present?}", placeholder: "Powtórz PIN").on :key_up do |e|
                    mutate.user['pin_confirmation'] = e.target.value
                    mutate.errors['pin_confirmation'] = nil
                  end
                  if (state.errors || {})['pin_confirmation'].present?
                    div(class: "invalid-feedback") do
                      (state.errors || {})['pin_confirmation'].to_s;
                    end
                  end
                end
              end

            end

            p do
              "Nadaj PIN składający się z minimum 4 cyfr, który będzie wymagany do odzyskania hasła. Dzięki niemu niepożądane osoby nie będą mogły sprawdzić czy Twój e-mail jest w naszej bazie."
            end

            div(class: "form-check form-check-inline w-80p ml-10p") do
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
                div(class: "invalid-feedback") do
                  (state.errors || {})['terms_acceptation'].to_s;
                end
              end
            end

            div(class: "text-center") do
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
          p(class: "text-center") do
            span {'Nie pamiętasz hasła? '}
            a(class: "text-primary") do
              'Zrestartuj hasło'
            end.on :click do |e|
              reset_password
            end
          end
          p(class: "text-center") do
            span {'Masz już konto? '}
            a(class: "text-primary") do
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
          p(class: 'text-center') { 'Jesteś aktualnie zalogowany! Wyloguj się, by przejść proces rejestracji' }
        end
        div(class: 'modal-footer text-center') do
          button(class: 'btn btn-secondary btn-cons mt-3 mb-3', type: "button") do
            'Zamknij okno'
          end.on :click do
            close_modal
          end
        end
      end
    end

    def render
      div(class: 'modal fade', id: 'registration-modal', role: "dialog", tabIndex: "-1") do
        div(class: 'modal-dialog', role: "document") do
          div(class: 'modal-content') do
            div(class: 'modal-header') do
              h5(class: 'modal-title') { 'Zarejestruj się' }
              button(class: 'close', type: "button") do
                span do
                  i(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
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

