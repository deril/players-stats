class RenameStartedAtToTimestampInPlaythrough < ActiveRecord::Migration[7.2]
  def change
    rename_column :playthroughs, :started_at, :timestamp
  end
end
