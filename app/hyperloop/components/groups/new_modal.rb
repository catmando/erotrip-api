class GroupsNewModal < Hyperloop::Component
  include BaseModal

  state group: {}
  state errors: {}

  state current_file: {
    result: nil,
    src: nil,
    filename: nil,
    filetype: nil,
    error: nil
  }

  after_mount do
    if CurrentUserStore.current_user.blank?
      ModalsService.open_modal(AuthWarningModal, { callback: proc { ModalsService.open_modal(GroupsNewModal, { size_class: 'modal-lg' }) } })
      close
    else
      mutate.group {}
    end
  end

  def title
    'Utwórz nową grupę'
  end

  def render_modal
    span do
      div(class: 'modal-body') do
        div.row do
          div.col.col_xs_12.col_sm_7 do

            div.form_group do
              label {'Nazwa'}
              input(placeholder: "Nazwa", name: 'name', class: "form-control #{'is-invalid' if (state.errors || {})['name'].present?}").on :key_up do |e|
                mutate.group['name'] = e.target.value
                mutate.errors['name'] = nil
              end
              if (state.errors || {})['name'].present?
                div.invalid_feedback do
                  (state.errors || {})['name'].to_s;
                end
              end
            end

            div.form_group do
              label {'Opis'}
              textarea(placeholder: "Opis", name: 'desc', class: "form-control #{'is-invalid' if (state.errors || {})['desc'].present?}").on :key_up do |e|
                mutate.group['desc'] = e.target.value
                mutate.errors['desc'] = nil
              end
              if (state.errors || {})['desc'].present?
                div.invalid_feedback do
                  (state.errors || {})['desc'].to_s;
                end
              end
            end

            div.form_group do
              label {'Rodzaj'}
              MultiSelect(placeholder: "Rodzaj", name: 'kinds', className: "form-control #{'is-invalid' if (state.errors || {})['kinds'].present?}", selection: state.group['kinds'] || [], options: Commons.account_kinds).on :change do |e|
                `console.log('changed:', e)`
                puts Array.new(e.to_n)
                mutate.group['kinds'] = Array.new(e.to_n)
                mutate.errors['kinds'] = nil
              end
              if (state.errors || {})['kinds'].present?
                div.invalid_feedback do
                  (state.errors || {})['kinds'].to_s;
                end
              end
            end

          end
          div.col.col_xs_12.col_sm_5 do
            # Dropzone(onDrop: proc{ |accepted, rejected| file_dropped(accepted, rejected) })
            div.form_group do
              label {'Zdjęcie'}
              DropNCrop(instructions: dropzone_instructions, value: state.current_file.to_n, cropperOptions: { aspectRatio: 1 }.to_n, canvasHeight: '275px').on :change do |event|
                file_changed Hash.new(event.to_n)
              end
            end
            if (state.errors || {})['photo_uri'].present?
              div.custom_select.is_invalid.d_none
              div.invalid_feedback do
                (state.errors || {})['photo_uri'].to_s;
              end
            end
          end
        end
      end

      div(class: 'modal-footer', style: {justifyContent: 'center', paddingTop: 0}) do
        button(class: 'btn btn-secondary btn-cons mt-3 mb-3', type: "button") do
          'Utwórz'
        end.on :click do
          save_group
        end
      end
    end
  end

  def save_group
    mutate.blocking true
    SaveGroup.run(state.group)
    .then do |data|
      puts 'THEN'
      mutate.blocking false
      `toast.success('Dodaliśmy nową grupę.')`
      close
    end
    .fail do |e|
      mutate.blocking false
      `toast.error('Nie udało się zarejestrować.')`
      if e.class.name.to_s == 'ArgumentError'
        errors = JSON.parse(e.message.gsub('=>', ':'))
        errors.each do |k, v|
          errors[k] = v.join('; ')
        end
        mutate.errors errors
      elsif e.is_a?(Hyperloop::Operation::ValidationException)
        mutate.errors e.errors.message
      end
      {}
    end
  end

  def file_changed data
    if state.current_file['error'].blank?
      mutate.current_file data
      mutate.group['photo_uri'] = "#{state.current_file['result']};#{state.current_file['filename']}"
    else
      `toast.error('Nie udało się załadować obrazka')`
    end
  end

  def dropzone_instructions
    val = [
      React.create_element('div', {key: 'ero-1', className: 'btn btn-secondary mb-2'}) { 'Wybierz' },
      React.create_element('div', {key: 'ero-2', }) {'lub przeciągnij'},
      React.create_element('div', {key: 'ero-3', }) {'tutaj'}
    ]
    val.to_n
  end

end