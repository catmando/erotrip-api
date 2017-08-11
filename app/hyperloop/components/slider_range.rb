  class SliderRange < Hyperloop::Component

    param selection: [20, 30]
    param name: "no_name_configured"
    param min: 18
    param max: 40


    def changed(val)
      mutate.selection val
    end

    after_mount do
      mutate.selection params[:selection]
      mutate.default_selection params[:selection]
    end

    def render
      DIV(class: 'range') do
        DIV(class: 'value-min') do
          "#{state.selection ? state.selection[0] : ''}"
        end

        ReactRange(name: params[:name], min: params[:min], max: params[:max], defaultValue: params[:selection], onChange: lambda{ |val| changed(val)} )

        DIV(class: 'value-max') do
          "#{state.selection ? state.selection[1] : ''}"
        end
      end
    end
  end
