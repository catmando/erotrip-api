class Select < Hyperloop::Component

  param placeholder: ""
  param selection: ''
  param name: "no_name_configured"
  param className: ''
  param onChange: nil

  param options: [
    { value: 'one', label: 'Please provide' },
    { value: 'two', label: 'some options' }
  ]

  def changed(val)
    mutate.selection Hash.new(val.to_n)['value'] || ''
    params.onChange.call(state.selection) if params.onChange.present?
  end

  after_mount do
    mutate.selection params[:selection]
  end

  def render
    ReactSelect(name: params[:name], className: params['className'], value: state.selection, options: params[:options].to_n, placeholder: params[:placeholder], multi: false).on :change do |e|
      changed(e)
    end
  end
end

