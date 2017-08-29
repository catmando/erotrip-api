class CurrentUserStore < Hyperloop::Store

  state current_user: nil
  state current_user_id: nil
  # , initialize: :init_current_user

  def self.current_user
    state.current_user
  end

  def self.current_user_id
    state.current_user_id
  end

  def self.current_user!(new_val)
    mutate.current_user new_val
  end

  def self.current_user_id!(new_val)
    mutate.current_user_id new_val
    self.init_current_user
  end

  def self.init_current_user
    if state.current_user_id.present?
      puts "INITIALIZING current_user based on id: #{state.current_user_id}"
      mutate.current_user User.find(state.current_user_id)
    else
      puts "NO CURRENT USER"
      mutate.current_user nil
    end
  end

  receives Hyperloop::Application::Boot do
    mutate.current_user_id Hyperloop::Application.acting_user_id.try(:to_i)
  end

end