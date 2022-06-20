class AddUniqueIndexToPlaylists < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def self.up
    if index_exists?(:playlists, %i[playlistable_type playlistable_id])
      remove_index :playlists, column: %i[playlistable_type playlistable_id], algorithm: :concurrently
    end

    add_index :playlists, %i[playlistable_type playlistable_id], unique: true, algorithm: :concurrently
  end

  def self.down
    remove_index :playlists, column: %i[playlistable_type playlistable_id], algorithm: :concurrently
  end
end
