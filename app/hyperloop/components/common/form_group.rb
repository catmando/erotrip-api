class FormGroup < Hyperloop::Component

  param label: nil, nils: true
  param error: nil, nils: true

  def render
    div(class: 'form-group') do
      label { params.label } if params.label.present?

      children.each do |child|
        classes = child.props.className || ''
        classes += ' is-invalid' if params.error.present?
        child.render(class: classes)
      end

      div(class: 'invalid-feedback') { params.error } if params.error.present?
    end
  end

end