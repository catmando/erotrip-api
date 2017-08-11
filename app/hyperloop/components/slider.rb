  class EaSlider < Hyperloop::Component

    param selection: 30
    param name: "no_name_configured"
    param min: 18
    param max: 40


    def changed(val)
      mutate.selection val
      nil
    end

    before_mount do; end

    after_mount do
      mutate.selection params[:selection]
      mutate.default_selection params[:selection]
    end

    before_update do; end

    before_unmount do; end

    def render
      DIV(class: 'range') do

        Slider(name: params[:name], defaultValue: state.default_selection, onChange: lambda{ |val| changed(val)} )

        DIV(class: 'value-max') do
          "#{state.selection}"
        end
      end
    end
  end

