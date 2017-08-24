class MultiSelectWithLabels < Hyperloop::Component

  param placeholder: ""
  param selection: ''
  param name: "no_name_configured[]"

  param options: [
    { value: 'one', label: 'Please provide' },
    { value: 'two', label: 'some options' }
  ]
  param onChange: nil

  def add(val)
    mutate.selection ""
    mutate.selections_memo [ state.selections_memo, Hash.new(val.to_n)['value'] ].flatten.compact.uniq
    params.onChange.call(state.selections_memo) if params.onChange.present?
  end

  def remove(val)
    mutate.selections_memo state.selections_memo - [val]
    params.onChange.call(state.selections_memo) if params.onChange.present?
  end

  after_mount do
    mutate.selection ""
    mutate.selections_memo params[:selection]
  end

  def render
    DIV(class: 'select-with-labels') do
      ReactSelect(value: state.selection.to_n, options: params[:options].select{ |opt| !(state.selections_memo || []).include?(opt['value']) }.to_n, placeholder: params[:placeholder]).on :change do |e|
        add(e)
      end
      DIV(class: 'labels-wrapper') do
        (state.selections_memo || []).each_with_index do |item, index|
          DIV(key: index, class: "badge badge-default mr-2") do
            INPUT(type: 'hidden', name: params[:name], value: item)
            BUTTON(type: "button", class: "btn btn-link") do
              'x'
            end.on :click do |e|
              remove(item)
            end
            SPAN do
              params[:options].select{|opt| opt['value'] == item}[0]['label']
            end
          end
        end
      end
    end
  end
end