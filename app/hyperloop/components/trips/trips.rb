class Trips < Hyperloop::Router::Component

  def render
    div(class: 'row') do
      div(class: 'col-12 col-lg-9 ml-lg-auto') do
        a(class: 'text-primary') { 'Auth Warning Modal' }.on :click do |e|
          ModalsService.open_modal(AuthWarningModal)
        end
      end
    end
  end

end