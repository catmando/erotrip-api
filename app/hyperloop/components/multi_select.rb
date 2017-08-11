  class MultiSelect < Hyperloop::Component

    # Select = require('react-select')
    # param :placeholder
    param placeholder: ""
    param options: [
        { value: 'none', label: 'No options provided' }
      ]
    param selection: ''
    param name: "no_name_configured"
    # param :param_with_default2, default: "default value" # alternative syntax
    # param :param_with_type, type: Hash
    # param :array_of_hashes, type: [Hash]
    # collect_other_params_as :attributes

    # The following are the most common lifecycle call backs,
    # the following are the most common lifecycle call backs# delete any that you are not using.
    # call backs may also reference an instance method i.e. before_mount :my_method
    # state.selection = []
    # params[:selection]

    def log_change(val)
      puts "current val: #{val}"
      `console.log(JSON.stringify(val));`
      mutate.selection val
      nil
    end

    before_mount do
      # any initialization particularly of state variables goes here.
      # this will execute on server (prerendering) and client.
    end

    after_mount do
      mutate.selection params[:selection]
      # any client only post rendering initialization goes here.
      # i.e. start timers, HTTP requests, and low level jquery operations etc.
    end

    before_update do
      # called whenever a component will be re-rerendered
    end

    before_unmount do
      # cleanup any thing (i.e. timers) before component is destroyed
    end

    def render
      # DIV do
      #   "#{state.placeholder}"
      # end
      DIV do
        DIV do
          # "OPTIONSY >>#{JSON.stringify(state.selection)}<< >>#{JSON.stringify(params[:selection])}<<"
          # `JSON.stringify(this.state.selection)`
        end
        Select(name: params[:name], value: state.selection, options: params[:options], placeholder: params[:placeholder], multi: true, delimiter: "|", joinValues: true, onChange: lambda{ |val| log_change(val)} )

        # .on(:change) do |e|
        #   puts e.inspect
        #   `console.log(e);`
        # end
          # puts ">> #{e.to_s}"
        #   `console.log(this);`
        #   mutate.selection e
        # end
        #   # console.log 'halo koalo'
        #   mutate.selection state.selection
        # end
      end
      # DIV do
      #   "dupa"
      # end

    end
  end

