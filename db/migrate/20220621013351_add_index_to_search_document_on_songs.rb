class AddIndexToSearchDocumentOnSongs < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :songs, :search_document, using: "gin", algorithm: :concurrently
  end
end
