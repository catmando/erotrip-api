class SliderRange < Hyperloop::Component

  param selection: [20, 30]
  param name: "no_name_configured[]"
  param min: 18
  param max: 40


  def changed(val)
    mutate.selection Array.new(val.to_n)
  end

  after_mount do
    mutate.selection params[:selection].map(&:to_i)
  end

  def render
    DIV(class: 'range') do
      DIV(class: 'value-min') do
        "#{state.selection ? state.selection[0] : ''}"
      end

      ReactRange(name: params[:name], min: params[:min].to_i, max: params[:max].to_i, defaultValue: params[:selection].map(&:to_i)).on :change do |e|
        changed(e)
      end

      DIV(class: 'value-max') do
        "#{state.selection ? state.selection[1] : ''}"
      end

      INPUT(type: 'hidden', value: (state.selection || [])[0], name: params[:name])
      INPUT(type: 'hidden', value: (state.selection || [])[1], name: params[:name])
    end
  end
end
