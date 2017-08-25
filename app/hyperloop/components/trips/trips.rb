class Trips < Hyperloop::Router::Component

  def render
    div(class: 'row') do
      div(class: 'col-12 col-lg-9 ml-lg-auto') do
        a(class: 'text-primary') { 'Auth Warning Modal' }.on :click do |e|
          RootStore.open_modal('auth_warning')
        end
      end
    end
  end

end