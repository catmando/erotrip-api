class MoveGroupUuidToId < ActiveRecord::Migration[5.1]
  def up

    add_column :groups, :not_uuid, 'SERIAL', null: false

    change_table :groups do |t|
      t.remove :id
      t.rename :not_uuid, :id
    end
    execute "ALTER TABLE groups ADD PRIMARY KEY (id);"

  end

  def down
    enable_extension "uuid-ossp"
    add_column :groups, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    change_table :groups do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE groups ADD PRIMARY KEY (id);"
  end
end
