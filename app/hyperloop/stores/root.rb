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
    puts "CLOSING MODAL, #{name}"
    mutate.opened_modals[name] = false
    # mutate.opened_modals state.opened_modals
  end

  receives Hyperloop::Application::Boot do
    mutate.opened_modals({})
  end

end