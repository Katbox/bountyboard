class ChangeUserEmailToCitext < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public"
    execute "ALTER TABLE users ALTER email TYPE citext"
  end

  def down
    execute "ALTER TABLE users ALTER email TYPE character varying(255) "
  end
end
