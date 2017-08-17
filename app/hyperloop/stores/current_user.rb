class CurrentUserStore < Hyperloop::Store

  state current_user: nil, initialize: :init_current_user

  def self.current_user
    state.current_user
  end

  def self.set_current_user(new_val)
    puts 'set current_user'
    mutate.current_user new_val
  end

  # def self.log_in
  #   mutate.current_user User.new({first_name: 'Jacek', last_name: 'Placek'})
  #   puts "after log in #{state.current_user.inspect}"
  # end

  # def self.log_out
  #   mutate.current_user nil
  # end

  def init_current_user
    puts 'initializing!'
    if Hyperloop::Application.acting_user_id.present?
      mutate.current_user User.current
    else
      mutate.current_user nil
    end
  end

end