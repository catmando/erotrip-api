class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  KINDS = %w( man woman couple men_couple women_couple tgsv )

  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable unless RUBY_ENGINE == 'opal'

  validates :kind, :name, :birth_year, :city, :pin, presence: true

  validates :name_second_person, :birth_year_second_person, presence: true, if: :kind_for_many_people?

  validates :pin, numericality: { greater_than_or_equal_to: 1000 }

  validates :kind, inclusion: { in: KINDS }

  validates :terms_acceptation, acceptance: { message: 'musi zostać zaakceptowane' }

  validate :pin_confirmation_the_same

  attr_accessor :pin_confirmation

  def pin_confirmation_the_same
    errors.add :pin_confirmation, 'nie zgadza się z PINem' if pin_confirmation.present? && pin.present? && pin_confirmation.to_i != pin.to_i
  end

  def kind_for_many_people?
    kind.present? && !['man', 'woman'].include?(kind)
  end

  def self.current
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

  def self.fetch_collection per_page=25, offset=0
    puts 'WILL LOAD USERS'
    puts per_page
    puts offset
    order(created_at: :desc).limit(per_page).offset(offset)
  end
end
