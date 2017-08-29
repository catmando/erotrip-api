class ChangeKindsInGroup < ActiveRecord::Migration[5.1]
  def up
    change_column :groups, :kinds, :jsonb
  end
  def down
    change_column :groups, :kinds, :json
  end
end
