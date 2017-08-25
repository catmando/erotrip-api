class GroupsNewModal < Hyperloop::Component

  state blocking: false
  state group: {}
  state errors: {}

  after_mount do
    mutate.group {}
    mutate.blocking(false)
    `$('#groups-new-modal').modal({backdrop: 'static', show: true})`
  end

  def close_modal
    `$('#groups-new-modal').modal('hide')`
    mutate.blocking(false)
    mutate.group {}
    RootStore.close_modal('groups_new')
  end

  def save_group
    mutate.blocking true
    SaveGroup.run(state.group)
    .then do |data|
      mutate.blocking false
      `toast.success('Dodaliśmy nową grupę.')`
      close_modal
    end
    .fail do |e|
      mutate.blocking false
      `toast.error('Nie udało się zarejestrować.')`
      if e.is_a?(HTTP)
        if JSON.parse(e.body)['id'].present?
          CurrentUserStore.current_user_id! JSON.parse(e.body)['id']
          close_modal
        end
        errors = JSON.parse(e.body)['errors']
        errors.each do |k, v|
          errors[k] = v.join('; ')
        end
        mutate.errors errors

      elsif e.is_a?(Hyperloop::Operation::ValidationException)
        puts e.errors.message
        mutate.errors e.errors.message
      end
      {}
    end
  end

  def render
    div(id: 'groups-new-modal', class: "modal fade", role: "dialog", tabIndex: "-1") do
      div(class: 'modal-dialog modal-lg', role: "document") do
        div(class: 'modal-content') do

          div(class: 'modal-header') do
            h5(class: 'modal-title') { 'Utwórz nową grupę' }
            button(class: 'close', type: "button") do
              span do
                i(class: 'ero-cross f-s-20 d-inline-block rotated-45deg')
              end
            end.on :click do
              close_modal
            end
          end

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
                  MultiSelect(placeholder: "Rodzaj", name: 'kinds', className: "form-control #{'is-invalid' if (state.errors || {})['kinds'].present?}", selection: state.group['kinds'] || [], options: RootStore.account_kinds).on :change do |e|
                    mutate.group['kinds'] = e.to_n
                    mutate.errors['kinds'] = nil
                  end
                  if (state.errors || {})['kinds'].present?
                    div.invalid_feedback do
                      (state.errors || {})['kinds'].to_s;
                    end
                  end
                end

              end
              div.col.col_xs_12.col_sm_4 do
                'upload plikow!'
              end
            end
          end

          div(class: 'modal-footer', style: {justifyContent: 'center'}) do
            button(class: 'btn btn-secondary btn-cons mt-3 mb-3', type: "button") do
              'Utwórz'
            end.on :click do
              save_group
            end
          end

        end
      end
    end
  end

end