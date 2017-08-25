class RootStore < Hyperloop::Store

  state :opened_modals
  # : {login: false, registration: false}

  def self.opened_modals
    state.opened_modals
  end

  def self.open_modal(name)
    puts "OPENING MODAL #{name}"
    mutate.opened_modals[name] = true
    mutate.opened_modals state.opened_modals
    puts state.opened_modals
  end

  def self.close_modal(name)
    mutate.opened_modals[name] = false
    mutate.opened_modals state.opened_modals
  end

  receives Hyperloop::Application::Boot do
    mutate.opened_modals({})
  end


  # STATIC GETTERS
  def self.account_kinds
    [
      {label: 'Kobieta', value: 'woman'},
      {label: 'Mężczyzna', value: 'man'},
      {label: 'Para hetero', value: 'couple'},
      {label: 'Para kobiet', value: 'women_couple'},
      {label: 'Para mężczyzn', value: 'men_couple'},
      {label: 'TGSV', value: 'tgsv'}
    ]
  end

end