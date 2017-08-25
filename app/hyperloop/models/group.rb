# name: string
# desc: text
# photo: string
# kinds: string[]

# timestamps

class Group < ApplicationRecord
  KINDS = %w( man woman couple men_couple women_couple tgsv )

  validates :kinds, :name, :desc, presence: true

end