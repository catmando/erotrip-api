class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable unless RUBY_ENGINE == 'opal'

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def self.current
    Hyperloop::Application.acting_user_id.present? ? find(Hyperloop::Application.acting_user_id) : nil
  end
end
