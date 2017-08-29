class SliderRange < Hyperloop::Component

  param selection: [20, 30]
  param name: "no_name_configured[]"
  param min: 18
  param max: 40
  param onChange: nil

  before_update do
    if params.selection != state.selection
      mutate.selection params.selection
    end
  end

  after_mount do
    mutate.selection (params[:selection] || []).map(&:to_i)

  end

  def render
    div(class: 'range') do
      div(class: 'value-min') do
        "#{state.selection ? state.selection[0] : ''}"
      end

      ReactRange(name: params[:name], min: params[:min].to_i, max: params[:max].to_i, defaultValue: (params[:selection] || []).map(&:to_i)).on :change do |e|
        changed(e)
      end

      div(class: 'value-max') do
        "#{state.selection ? state.selection[1] : ''}"
      end

      input(type: 'hidden', value: (state.selection || [])[0], name: params[:name])
      input(type: 'hidden', value: (state.selection || [])[1], name: params[:name])
    end
  end

  def changed(val)
    mutate.selection Array.new(val.to_n)
    params.onChange.call(state.selection) if params.onChange.present?
  end
end
