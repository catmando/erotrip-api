class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.uuid :created_by_id
      t.uuid :updated_by_id

      t.timestamps
    end
    add_foreign_key :users, :users, column: :created_by_id
    add_foreign_key :users, :users, column: :updated_by_id
  end
end
