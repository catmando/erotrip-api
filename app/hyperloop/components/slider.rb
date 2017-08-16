  class Slider < Hyperloop::Component

    param selection: 30
    param name: "no_name_configured"

    def changed(val)
      mutate.selection val
      # `hyperconsole()`
      # console
       # context: 'Slider.instance'
      nil
    end

    after_mount do
      mutate.selection params[:selection].to_i
    end

    def render
      DIV(class: 'range') do

        ReactSlider(name: params[:name], defaultValue: params[:selection].to_i ).on :change do |e|
          changed(e.to_n)
          # `console.log(e);`
          # puts e.native
        end
        # , onChange: lambda{ |val| changed(val)}

        DIV(class: 'value-max') do
          "#{state.selection}"
        end

        INPUT(type: 'hidden', value: state.selection, name: params[:name])
      end
    end
  end

