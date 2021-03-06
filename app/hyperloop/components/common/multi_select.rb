class MultiSelect < Hyperloop::Component

  param placeholder: ""
  param selection: []
  param name: "no_name_configured[]"
  param className: ''

  param options: [
    { value: 'one', label: 'Please provide' },
    { value: 'two', label: 'some options' }
  ]
  param onChange: nil

  # before_update do
  #   if params.selection != state.selection
  #     mutate.selection params.selection
  #   end
  # end

  after_mount do
    mutate.selection params[:selection]
  end

  def render
    ReactSelect(name: params[:name], className: params['className'], value: state.selection.to_n, options: params[:options].to_n, placeholder: params[:placeholder], multi: true).on :change do |e|
      changed(e)
    end
  end

  def changed(val)
    mutate.selection Array.new(val.to_n).map{ |item| Hash.new(item)['value'] || nil }.compact.uniq
    params.onChange.call(state.selection) if params.onChange.present?
  end
end

