class AddPublicUsersCountToGroups < ActiveRecord::Migration[5.1]

  def self.up

    add_column :groups, :public_users_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :groups, :public_users_count

  end

end
