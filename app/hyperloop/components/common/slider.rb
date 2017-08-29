class Slider < Hyperloop::Component

  param selection: 30
  param name: "no_name_configured"
  param onChange: nil

  before_update do
    if params.selection != state.selection
      mutate.selection params.selection
    end
  end

  after_mount do
    mutate.selection params[:selection].to_i
  end

  def render
    div(class: 'range') do

      ReactSlider(name: params[:name], defaultValue: params[:selection].to_i ).on :change do |e|
        changed(e.to_n)
      end

      div(class: 'value-max') do
        "#{state.selection}"
      end

      input(type: 'hidden', value: state.selection, name: params[:name])
    end
  end

  def changed(val)
    mutate.selection val
    params.onChange.call(state.selection) if params.onChange.present?
  end
end

