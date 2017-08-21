class CurrentUserStore < Hyperloop::Store

  state current_user: nil
  state current_user_id: nil
  # , initialize: :init_current_user

  def self.current_user
    # if state.current_user_id.present? && state.current_user.blank?
    #   init_current_user
    # end
    state.current_user
  end

  def self.current_user!(new_val)
    mutate.current_user new_val
  end

  def self.current_user_id!(new_val)
    puts "SETTING current_user_id: #{new_val}"
    mutate.current_user_id new_val
    self.init_current_user
  end

  # def self.log_in
  #   mutate.current_user User.new({first_name: 'Jacek', last_name: 'Placek'})
  #   puts "after log in #{state.current_user.inspect}"
  # end

  # def self.log_out
  #   mutate.current_user nil
  # end

  def self.init_current_user
    puts "INITIALIZING current_user based on id: #{state.current_user_id}"
    if state.current_user_id.present?
      mutate.current_user User.find(state.current_user_id)
    else
      mutate.current_user nil
    end
  end

  receives Hyperloop::Application::Boot do
    `console.log('BOOTING');`
    mutate.current_user_id Hyperloop::Application.acting_user_id
    # self.current_user_id! Hyperloop::Application.acting_user_id
  end

end