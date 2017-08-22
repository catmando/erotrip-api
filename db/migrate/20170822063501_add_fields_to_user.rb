class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :kind, :string
    add_index :users, :kind
    add_column :users, :name, :string
    add_column :users, :birth_year, :integer
    add_column :users, :name_second_person, :string
    add_column :users, :birth_year_second_person, :integer
    add_column :users, :city, :string
    add_column :users, :pin, :integer
    add_index :users, :pin
    add_column :users, :terms_acceptation, :boolean
    add_index :users, :terms_acceptation

    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
