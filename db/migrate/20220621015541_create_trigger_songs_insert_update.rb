# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerSongsInsertUpdate < ActiveRecord::Migration[6.1]
  def up
    create_trigger("update_search_document", :generated => true, :compatibility => 1).
        on("songs").
        name("update_search_document").
        before(:insert, :update).
        for_each(:row) do
      <<-SQL_ACTIONS
NEW.search_document := 
  setweight(to_tsvector('simple'::regconfig, coalesce(NEW.title, '')), 'A') ||
  setweight(to_tsvector('simple'::regconfig, coalesce(NEW.cached_artist_name, '')), 'B') ||
  setweight(to_tsvector('simple'::regconfig, coalesce(NEW.cached_album_name, '')), 'C');
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("update_search_document", "songs", :generated => true)
  end
end
