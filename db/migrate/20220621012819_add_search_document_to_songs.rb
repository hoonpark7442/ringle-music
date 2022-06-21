class AddSearchDocumentToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :search_document, :tsvector
  end
end
