class MultiSelectWithLabels < Hyperloop::Component

  param placeholder: ""
  param selection: ''
  param name: "no_name_configured[]"

  param options: [
    { value: 'one', label: 'Please provide' },
    { value: 'two', label: 'some options' }
  ]
  param onChange: nil

  before_update do
    if params.selection != state.selection
      mutate.selection params.selection
    end
  end

  after_mount do
    mutate.selection ""
    mutate.selections_memo params[:selection]
  end

  def render
    div(class: 'select-with-labels') do
      ReactSelect(value: state.selection.to_n, options: params[:options].select{ |opt| !(state.selections_memo || []).include?(opt['value']) }.to_n, placeholder: params[:placeholder]).on :change do |e|
        add(e)
      end
      div(class: 'labels-wrapper') do
        (state.selections_memo || []).each_with_index do |item, index|
          div(key: index, class: "badge badge-default mr-2") do
            input(type: 'hidden', name: params[:name], value: item)
            button(type: "button", class: "btn btn-link") do
              'x'
            end.on :click do |e|
              remove(item)
            end
            span do
              params[:options].select{|opt| opt['value'] == item}[0]['label']
            end
          end
        end
      end
    end
  end

  def add(val)
    mutate.selection ""
    mutate.selections_memo [ state.selections_memo, Hash.new(val.to_n)['value'] ].flatten.compact.uniq
    params.onChange.call(state.selections_memo) if params.onChange.present?
  end

  def remove(val)
    mutate.selections_memo state.selections_memo - [val]
    params.onChange.call(state.selections_memo) if params.onChange.present?
  end

end
