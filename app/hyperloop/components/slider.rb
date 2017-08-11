  class Slider < Hyperloop::Component

    param selection: 30
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

        ReactSlider(name: params[:name], defaultValue: params[:selection], onChange: lambda{ |val| changed(val)} )

        DIV(class: 'value-max') do
          "#{state.selection}"
        end
      end
    end
  end

