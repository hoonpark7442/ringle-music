module Playlists
	class Destroyer
		def initialize(playlistable, song_ids)
      @playlistable = playlistable
      @song_ids = song_ids
    end

    def self.call(...)
      new(...).call
    end

    def call
      PlaylistSong.where(song_id: song_ids).destroy_all
      true
    rescue => e
      Rails.logger.send(:fatal, "#{e}: #{e.message}\n#{e.backtrace.join("\n")}")
      false
    end

    private

    attr_reader :playlistable, :song_ids

    
	end
end