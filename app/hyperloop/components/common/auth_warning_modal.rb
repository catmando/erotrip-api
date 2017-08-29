class AuthWarningModal < Hyperloop::Component
  include BaseModal

  def title
    'Musisz być zalogowany'
  end

  def render_modal
    span do
      div(class: 'modal-body') do
        p(class: 'text-center mb-0 f-s-15') do
          span(class: 'text-gray-dark') { 'Ta czynność wymaga zalogowanego użytkownika' }
          # br
          # span(class: 'text-gray-dark') { 'Zaloguj się albo zarejestruj' }
        end
      end

      div(class: 'modal-footer text-center justify-content-between pt-0') do

        button(class: "btn btn-secondary mt-3 mb-3") { 'Zarejestruj się' }.on :click do |e|
          ModalsService.open_modal(RegistrationModal, {proc_to_call: params.proc_to_call})
          close
        end

        p(class: "or mb-0") do
          span {'-'}
          span {'ALBO'}
          span {'-'}
        end

        button(class: 'btn btn-primary mt-3 mb-3') { 'Zaloguj się' }.on :click do |e|
          ModalsService.open_modal(LoginModal, {proc_to_call: params.proc_to_call})
          close
        end

      end

    end
  end
end

