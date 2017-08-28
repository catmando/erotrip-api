class RemoveKindsFromGroup < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :kinds
  end
end
