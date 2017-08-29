class AddKindsToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :kinds, :json
  end
end
