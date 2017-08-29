# email: string
# created_by_id: uuid
# updated_by_id: uuid
# encrypted_password: string
# reset_password_token: string
# reset_password_sent_at: datetime
# remember_created_at: datetime
# sign_in_count: integer
# current_sign_in_at: datetime
# last_sign_in_at: datetime
# current_sign_in_ip: inet
# last_sign_in_ip: inet
# kind: string
# name: string
# birth_year: integer
# name_second_person: string
# birth_year_second_person: integer
# city: string
# pin: integer
# terms_acceptation: boolean
# private: boolean
# searched_kinds, :json
# weight, :integer
# height, :integer
# body, :string
# smoker, :boolean
# alcohol, :boolean
# avatar, :string
# verification_photo, :string
# my_expectations, :string
# about_me, :text
# interests, :text
# likes, :text
# dislikes, :text
# ideal_partner, :text
# verified, :boolean

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

  has_many :user_groups
  has_many :groups, through: :user_groups

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
end
