class MoveUserUuidToId < ActiveRecord::Migration[5.1]
  def up

    add_column :users, :not_uuid, 'SERIAL', null: false

    change_table :users do |t|
      t.remove :created_by_id
      t.remove :updated_by_id
      t.remove :id
      t.rename :not_uuid, :id
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"

  end

  def down
    enable_extension "uuid-ossp"
    add_column :users, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
