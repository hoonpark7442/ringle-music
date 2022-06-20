class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.references :playlistable, polymorphic: true, null: false

      t.timestamps
    end
  end

  # def self.up
  #   create_table :playlists do |t|
  #     t.string :name, null: false
  #     t.references :playlistable, polymorphic: true, null: false

  #     t.timestamps
  #   end
  # end

  # def self.down
  #   remove_index :playlists, name: 'index_playlists_on_playlistable_type_and_playlistable_id'
  #   drop_table :playlists
  # end
end
