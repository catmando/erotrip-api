class AddProfileFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :searched_kinds, :json
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
    add_column :users, :body, :string
    add_index :users, :body
    add_column :users, :smoker, :boolean
    add_column :users, :alcohol, :boolean
    add_index :users, :alcohol
    add_column :users, :avatar, :string
    add_column :users, :verification_photo, :string
    add_column :users, :my_expectations, :string
    add_column :users, :about_me, :text
    add_column :users, :interests, :text
    add_column :users, :likes, :text
    add_column :users, :dislikes, :text
    add_column :users, :ideal_partner, :text
    add_column :users, :verified, :boolean
    add_index :users, :verified
  end
end
