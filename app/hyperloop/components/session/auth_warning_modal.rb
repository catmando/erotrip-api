class AuthWarningModal < Hyperloop::Component

  after_mount do
    mutate.blocking(false)
    `$('#auth-warning-modal').modal({backdrop: 'static', show: true})`
  end

  def close_modal
    `$('#auth-warning-modal').modal('hide')`
    RootStore.close_modal('auth_warning')
  end

  def render
    div(id: 'auth-warning-modal', class: "modal fadeable", role: "dialog", tabIndex: "-1") do
      div(class: 'modal-dialog', role: "document") do
        div(class: 'modal-content modal-auth-warning') do

          div(class: 'modal-header') do
            h5(class: 'modal-title') { 'Musisz być zalogowany' }
            button(class: 'close', type: "button") do
              span do
                i(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
              end
            end.on :click do
              close_modal
            end
          end

          div(class: 'modal-body') do
            p(class: 'text-center mb-0 f-s-15') do
              span(class: 'text-gray-dark') { 'Ta czynność wymaga zalogowanego użytkownika' }
              # br
              # span(class: 'text-gray-dark') { 'Zaloguj się albo zarejestruj' }
            end
          end

          div(class: 'modal-footer text-center justify-content-between pt-0') do

            button(class: "btn btn-secondary mt-3 mb-3") { 'Zarejestruj się' }.on :click do |e|
              RootStore.open_modal('registration')
              close_modal
            end

            p(class: "or mb-0") do
              span {'-'}
              span {'ALBO'}
              span {'-'}
            end

            button(class: 'btn btn-primary mt-3 mb-3') { 'Zaloguj się' }.on :click do |e|
              RootStore.open_modal('login')
              close_modal
            end

          end

        end
      end
    end
  end
end

