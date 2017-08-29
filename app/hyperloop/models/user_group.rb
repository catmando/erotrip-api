# user_id: integer
# group_id: integer
# public: boolean
# timestamps

class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, uniqueness: { scope: :user_id }

  unless RUBY_ENGINE == 'opal'
    counter_culture :group, column_name: proc {|model| model.public == true ? 'public_users_count' : model.public == false ? 'private_users_count' : nil }

    after_commit :touch_user

    def touch_user
      user.try(:touch)
    end
  end

end
