class Trips < Hyperloop::Router::Component

  def render
    div.row do
      div.col_12.col_lg_9.ml_lg_auto do
        a(class: 'text-primary') { 'Auth Warning Modal' }.on :click do |e|
          ModalsService.open_modal(AuthWarningModal)
        end
      end
    end
  end

end