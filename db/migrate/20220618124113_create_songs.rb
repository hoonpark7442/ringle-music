class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :favorite_counts
      t.string :cached_artist_name
      t.string :cached_album_name

      t.timestamps
    end
  end
end
