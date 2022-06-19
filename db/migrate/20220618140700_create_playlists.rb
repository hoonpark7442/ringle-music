class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.references :playlistable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
