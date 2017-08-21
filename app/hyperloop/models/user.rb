class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable unless RUBY_ENGINE == 'opal'

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def self.current
    sleep 3
    current_id = Hyperloop::Application.acting_user_id
    if current_id.present?
      puts "FETCHING current_user from DB: #{current_id}"
      u = find(current_id)
    else
      puts "No current_user_id, WON'T FETCH from DB"
      u = nil
    end
    puts "RETURNING current_user #{u.inspect}"
    u
  end
end
