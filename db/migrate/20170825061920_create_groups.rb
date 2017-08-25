class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name
      t.text :desc
      t.string :photo
      t.string :kinds, array: true, default: []

      t.timestamps
    end
    add_index :groups, :kinds
  end
end
