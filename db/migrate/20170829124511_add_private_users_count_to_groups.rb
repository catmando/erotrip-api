class AddPrivateUsersCountToGroups < ActiveRecord::Migration[5.1]

  def self.up

    add_column :groups, :private_users_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :groups, :private_users_count

  end

end
