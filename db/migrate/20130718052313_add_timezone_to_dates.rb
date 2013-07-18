class AddTimezoneToDates < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE bounties
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone,
        ALTER completed_at TYPE timestamp with time zone,
        ALTER complete_by TYPE timestamp with time zone,
        ALTER artwork_updated_at TYPE timestamp with time zone,
        ALTER preview_updated_at TYPE timestamp with time zone
    SQL

    execute <<-SQL
      ALTER TABLE candidacies
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone,
        ALTER accepted_at TYPE timestamp with time zone
    SQL

    execute <<-SQL
      ALTER TABLE favorites
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone
    SQL

    execute <<-SQL
      ALTER TABLE moods
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone
    SQL

    execute <<-SQL
      ALTER TABLE personalities
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone
    SQL

    execute <<-SQL
      ALTER TABLE users
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone
    SQL

    execute <<-SQL
      ALTER TABLE votes
        ALTER created_at TYPE timestamp with time zone,
        ALTER updated_at TYPE timestamp with time zone
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE bounties
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone,
        ALTER completed_at TYPE timestamp without time zone,
        ALTER complete_by TYPE date,
        ALTER artwork_updated_at TYPE timestamp without time zone,
        ALTER preview_updated_at TYPE timestamp without time zone
    SQL

    execute <<-SQL
      ALTER TABLE candidacies
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone,
        ALTER accepted_at TYPE timestamp without time zone
    SQL

    execute <<-SQL
      ALTER TABLE favorites
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone
    SQL

    execute <<-SQL
      ALTER TABLE moods
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone
    SQL

    execute <<-SQL
      ALTER TABLE personalities
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone
    SQL

    execute <<-SQL
      ALTER TABLE users
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone
    SQL

    execute <<-SQL
      ALTER TABLE votes
        ALTER created_at TYPE timestamp without time zone,
        ALTER updated_at TYPE timestamp without time zone
    SQL
  end
end
